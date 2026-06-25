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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 1. Controllo campi vuoti
        if (nome == null || nome.trim().isEmpty() ||
            cognome == null || cognome.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            request.setAttribute("errore", "Tutti i campi sono obbligatori!");
            request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
            return;
        }

        Utente nuovoUtente = new Utente(nome, cognome, email, password);
        UtenteDao dao = new UtenteDao();

        try {
            // 2. Controllo se l'email esiste già
            if (dao.emailEsistente(email)) {
                request.setAttribute("errore", "Attenzione: un account con questa email è già registrato!");
                request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
                return;
            }

            // 3. Procedi con il salvataggio
            boolean inserito = dao.salvaUtente(nuovoUtente);
            
            if (inserito) {
                // Successo: vai alla login
                response.sendRedirect(request.getContextPath() + "/LoginServlet?success=true");
            } else {
                request.setAttribute("errore", "Impossibile completare la registrazione. Riprova.");
                request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore di connessione al database: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
        }
    }
}