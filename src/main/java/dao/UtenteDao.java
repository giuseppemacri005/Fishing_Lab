package dao; 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

// Importiamo la classe Utente dal tuo pacchetto model per passarla come parametro
import model.Utente; 
public class UtenteDao {
    
    
    // Modifica 'fishing_lab' se il tuo schema su Workbench ha un nome diverso.
    private static final String URL = "jdbc:mysql://localhost:3306/fishing_lab?useSSL=false&serverTimezone=UTC";
    
    // Inserisci l'utente del tuo MySQL (di solito è root)
    private static final String USER = "root";
    
    // SCRIVI QUI LA PASSWORD CHE USI PER ACCEDERE A MYSQL WORKBENCH
    private static final String PASSWORD = "la_tua_password_di_workbench";
    
    public boolean salvaUtente(Utente utente) throws SQLException {
        // Query SQL: i punti di domanda verranno sostituiti dai dati reali dell'utente
        String query = "INSERT INTO utenti (nome, cognome, email, password) VALUES (?, ?, ?, ?)";
        
        try {
            // Registra esplicitamente il driver MySQL (evita l'errore 'No suitable driver' su Tomcat)
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Errore: Driver MySQL non trovato! Assicurati di aver messo il file .jar nella cartella lib.");
            e.printStackTrace();
        }

        // Il costrutto try-with-resources apre la connessione e lo statement, 
        // assicurandosi di chiuderli AUTOMATICAMENTE alla fine, liberando la memoria di MySQL.
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            // Sostituiamo i parametri '?' nell'ordine corretto della query
            ps.setString(1, utente.getNome());
            ps.setString(2, utente.getCognome());
            ps.setString(3, utente.getEmail());
            ps.setString(4, utente.getPassword()); 

            // Esegue l'inserimento sul database. Ritorna il numero di righe modificate.
            int righeSalvate = ps.executeUpdate();
            
            // Se ha inserito almeno 1 riga, l'operazione ha avuto successo (ritorna true)
            return righeSalvate > 0; 
        }
    }
}