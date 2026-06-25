package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Utente; 
import dao.UtenteDao; 

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/RegistrazioneServlet")
public class RegistrazioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Metodo GET: Mostra la pagina di registrazione prelevandola dalla cartella protetta
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Corretto: indirizza l'utente alla pagina di registrazione
        request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
    }

    /**
     * Metodo POST: Riceve ed elabora i dati inviati dal form di registrazione
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Imposta la codifica UTF-8 per evitare problemi con lettere accentate
        request.setCharacterEncoding("UTF-8");

        // 1. Recupero parametri dal form HTML
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 2. Controllo di validità dei dati (campi vuoti)
        if (nome == null || nome.trim().isEmpty() ||
            cognome == null || cognome.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            request.setAttribute("errore", "Tutti i campi sono obbligatori!");
            // Corretto: se mancano dati, ricarica registrazione.jsp
            request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
            return;
        }

        // 3. Creazione oggetto Utente e chiamata al database tramite il DAO
        Utente nuovoUtente = new Utente(nome, cognome, email, password);
        UtenteDao dao = new UtenteDao();

        try {
            boolean inserito = dao.salvaUtente(nuovoUtente);
            
            if (inserito) {
                // Registrazione completata con successo: ridirezioniamo alla LoginServlet
                response.sendRedirect(request.getContextPath() + "/LoginServlet?success=true");
            } else {
                request.setAttribute("errore", "Impossibile completare la registrazione. Riprova.");
                // Corretto: se l'inserimento fallisce, rimanda a registrazione.jsp
                request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            e.printStackTrace(); // Stampa l'errore dettagliato nella console di Tomcat
            
            // Gestione errore in caso di problemi al DB (es. email già duplicata)
            request.setAttribute("errore", "Errore di sistema: l'email potrebbe essere già registrata.");
            // Corretto: in caso di eccezione SQL, rimanda a registrazione.jsp
            request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
        }
    }
}