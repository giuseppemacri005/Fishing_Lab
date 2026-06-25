package control; // Assicurati che il package sia giusto

import java.io.IOException;
import java.util.List;
import model.Prodotto;
import dao.prodottoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CercaServlet")
public class CercaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("ricerca"); // Nome del parametro dell'input
        
        prodottoDAO dao = new prodottoDAO();
        try {
            List<Prodotto> risultati = dao.doSearch(query);
            request.setAttribute("prodotti", risultati);
            // Torniamo alla index passando i risultati
            request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/WEB-INF/view/index.jsp");
        }
    }
}