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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
<<<<<<< HEAD
       
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Utilizzo del DataSource centralizzato
            conn = connessione.getConnection();
            
=======

        try (Connection conn = connessione.getConnection()) {
>>>>>>> ca20a713df632e9526b4a7435f0eee1711498df6
            String sql = "SELECT email, ruolo FROM utente WHERE email = ? AND password = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession(true);
                        session.setAttribute("utenteEmail", rs.getString("email"));
                        session.setAttribute("utenteRuolo", rs.getString("ruolo"));
                        session.setAttribute("sessionToken", UUID.randomUUID().toString());

<<<<<<< HEAD
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
=======
                        // REDIRECT alla home: è la HomeServlet che deve caricare i prodotti!
                        response.sendRedirect(request.getContextPath() + "/home");
                    } else {
                        request.setAttribute("errore", "Email o Password errate!");
                        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
                    }
                }
>>>>>>> ca20a713df632e9526b4a7435f0eee1711498df6
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore DB: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}