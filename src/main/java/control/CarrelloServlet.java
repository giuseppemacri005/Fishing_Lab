package control;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Prodotto;
import dao.prodottoDAO; // Assicurati che il package sia quello giusto
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CarrelloServlet")
public class CarrelloServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
        
        if (carrello == null) {
            carrello = new ArrayList<>();
        }

        String id = request.getParameter("idProdotto");
        if (id != null) {
            prodottoDAO dao = new prodottoDAO();
            try {
                // Questa è la riga che prima ti dava errore
                Prodotto p = dao.doRetrieveByKey(Integer.parseInt(id));
                
                if (p != null) {
                    carrello.add(p);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        session.setAttribute("carrello", carrello);
        response.sendRedirect(request.getContextPath() + "/carrello.jsp");
    }
}