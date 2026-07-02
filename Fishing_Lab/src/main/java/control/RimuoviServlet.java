package control;

import java.io.IOException;
import java.util.List;
import model.Prodotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RimuoviServlet")
public class RimuoviServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
        
        String indexStr = request.getParameter("index");
        if (carrello != null && indexStr != null) {
            int index = Integer.parseInt(indexStr);
            if (index >= 0 && index < carrello.size()) {
                carrello.remove(index);
            }
        }
        response.sendRedirect(request.getContextPath() + "/carrello.jsp");
    }
}