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

        try (Connection conn = connessione.getConnection()) {
            String sql = "SELECT email, ruolo FROM utente WHERE email = ? AND password = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession(true);
                        
                        String emailDb = rs.getString("email");
                        String ruoloDb = rs.getString("ruolo");

                        // Salviamo i dati in sessione
                        session.setAttribute("utenteEmail", emailDb);
                        session.setAttribute("utenteRuolo", ruoloDb);
                        // Se la tua index.jsp usa ancora "userSessionKey", scommenta la riga sotto:
                        // session.setAttribute("userSessionKey", emailDb); 
                        
                        session.setAttribute("sessionToken", UUID.randomUUID().toString());

                        // --- LOGICA DI REINDIRIZZAMENTO IN BASE AL RUOLO ---
                        if (ruoloDb != null && ruoloDb.equalsIgnoreCase("admin")) {
                            // Se è admin, lo mandiamo DIRETTAMENTE alla pagina di aggiunta prodotti protetta
                            request.getRequestDispatcher("/WEB-INF/view/aggiunta.jsp").forward(request, response);
                        } else {
                            // Se è un cliente, facciamo il REDIRECT alla HomeServlet per caricare il catalogo
                            response.sendRedirect(request.getContextPath() + "/home");
                        }
                    } else {
                        request.setAttribute("errore", "Email o Password errate!");
                        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore DB: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}