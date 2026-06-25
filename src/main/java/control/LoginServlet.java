package control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.connessione;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Se si inserisce l'URL direttamente, rimanda alla login protetta
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
       
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Utilizzo del DataSource centralizzato
            conn = connessione.getConnection();
            
            String sql = "SELECT email, ruolo FROM utente WHERE email = ? AND password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("utenteLoggato", rs.getString("email"));
                session.setAttribute("utenteRuolo", rs.getString("ruolo"));
                
                // Generazione Token di sicurezza nella sessione (richiesto esplicitamente)
                String sessionToken = UUID.randomUUID().toString();
                session.setAttribute("sessionToken", sessionToken);

                // Carica la index protetta in /WEB-INF/view/
                request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
                return;
            } else {
                request.setAttribute("errore", "Email o Password errate!");
                request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore DB: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}