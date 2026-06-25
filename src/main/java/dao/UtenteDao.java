package dao; 

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Utente; 

public class UtenteDao {
    
    private static final String URL = "jdbc:mysql://localhost:3306/fishing_lab?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "Sonogiuseppe2005.";
    
    // Primo metodo: Salva Utente
    public boolean salvaUtente(Utente utente) throws SQLException {
        String query = "INSERT INTO utenti (nome, cognome, email, password) VALUES (?, ?, ?, ?)";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, utente.getNome());
            ps.setString(2, utente.getCognome());
            ps.setString(3, utente.getEmail());
            ps.setString(4, utente.getPassword()); 

            int righeSalvate = ps.executeUpdate();
            return righeSalvate > 0; 
        }
    }
    
    // Secondo metodo: Check Login (senza la graffa errata prima!)
    public Utente checkLogin(String email, String password) throws SQLException {
        Utente utente = null;
        String query = "SELECT * FROM utenti WHERE email = ? AND password = ?";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    utente = new Utente();
                    utente.setNome(rs.getString("nome"));
                    utente.setCognome(rs.getString("cognome"));
                    utente.setEmail(rs.getString("email"));
                }
            }
        }
        return utente; 
    }
}