package control;

import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.prodottoDAO; 
import model.Prodotto;

@WebServlet("/GestioneProdottiServlet")
public class GestioneProdottiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Recupero i parametri usando i "name" esatti del form della tua aggiunta.jsp
        String nome = request.getParameter("nome");
        String descrizione = request.getParameter("descrizione");
        String prezzoStr = request.getParameter("prezzo");
        String immagine = request.getParameter("immagine");

        try {
            // Conversione stringa -> numero decimale
            double prezzoInserito = Double.parseDouble(prezzoStr);

            // 2. Impacchetto i dati nel tuo oggetto Modello Prodotto.java
            Prodotto nuovoProdotto = new Prodotto();
            nuovoProdotto.setNomeProdotto(nome);
            nuovoProdotto.setDescrizione(descrizione);
            
            // Valorizziamo entrambi i campi prezzo per soddisfare i vincoli NOT NULL del DB
            nuovoProdotto.setPrezzoOriginale(prezzoInserito);  
            nuovoProdotto.setPrezzoScontato(prezzoInserito);
            
            nuovoProdotto.setImmagine(immagine);

            // 3. Chiamo la tua DAO con la "p" minuscola per salvare nel DB
            prodottoDAO dao = new prodottoDAO();
            dao.doSave(nuovoProdotto);

            // 4. Successo: rinfresco la pagina mostrando il messaggio nel box della JSP
            request.setAttribute("errore", "✨ Prodotto inserito con successo nel database!");
            request.getRequestDispatcher("/WEB-INF/view/aggiunta.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errore", "Formato del prezzo non valido! Usa un numero (es. 49.99).");
            request.getRequestDispatcher("/WEB-INF/view/aggiunta.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("[GestioneProdottiServlet] Errore SQL durante l'inserimento:");
            e.printStackTrace();
            request.setAttribute("errore", "Errore Database: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/aggiunta.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/aggiunta.jsp").forward(request, response);
    }
}