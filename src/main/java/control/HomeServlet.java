package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.prodottoDAO;
import model.Prodotto;

// Associa la servlet sia all'indirizzo esteso che alla cartella radice del sito
@WebServlet(urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
   
    private final prodottoDAO prodottoDAO = new prodottoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Chiamiamo il metodo del DAO per estrarre la lista dei prodotti dal DB
            List<Prodotto> catalogo = prodottoDAO.doRetrieveAll();
            
            // Iniettiamo la lista come attributo della richiesta
            request.setAttribute("prodotti", catalogo);
            
        } catch (SQLException e) {
            e.printStackTrace();
            // In caso di errore del DB inseriamo un messaggio descrittivo da stampare a schermo
            request.setAttribute("messaggioErrore", "Si è verificato un errore nel recupero del catalogo prodotti.");
        }

        // Forwarding verso la JSP nascosta (nessun accesso diretto consentito dall'esterno!)
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/index.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}