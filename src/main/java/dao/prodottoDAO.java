package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import model.Prodotto;

public class prodottoDAO {

    private static DataSource ds;

    // Il blocco statico aggancia il DataSource all'avvio del server tramite JNDI
    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            ds = (DataSource) envCtx.lookup("jdbc/fishing_lab_db");
        } catch (NamingException e) {
            System.err.println("Errore JNDI durante l'inizializzazione del DataSource: " + e.getMessage());
        }
    }

    /**
     * Recupera tutti i prodotti attivi dal database ordinandoli per inserimento.
     * Include la cancellazione logica richiesta: i prodotti con Attivo = 0 rimangono 
     * archiviati per gli ordini storici ma non compaiono nel catalogo pubblico.
     */
    public List<Prodotto> doRetrieveAll() throws SQLException {
        List<Prodotto> listaProdotti = new ArrayList<>();
        
        // Eseguiamo una JOIN per estrarre direttamente il nome del Brand associato
        String query = "SELECT P.*, B.Nome_Brand FROM PRODOTTO P JOIN BRAND B ON P.ID_Brand = B.ID_Brand WHERE P.Attivo = 1 ORDER BY P.IdProdotto";
        try (Connection con = ds.getConnection(); 
             PreparedStatement ps = con.prepareStatement(query); 
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setIdProdotto(rs.getInt("IdProdotto")); // Nota: IdProdotto
                prodotto.setNomeProdotto(rs.getString("NomeProdotto")); // Nota: NomeProdotto
                prodotto.setDescrizione(rs.getString("Descrizione"));
                prodotto.setPrezzoOriginale(rs.getDouble("PrezzoOriginale"));
                prodotto.setPrezzoScontato(rs.getDouble("PrezzoScontato"));
                prodotto.setNomeBrand(rs.getString("Nome_Brand")); // Nota: Nome_Brand (dalla tabella BRAND)
                prodotto.setImmagine(rs.getString("Immagine"));
                
                listaProdotti.add(prodotto);
            }
        }
        return listaProdotti;
    }
}