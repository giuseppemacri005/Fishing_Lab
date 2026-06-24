package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Prodotto;
import dao.connessione; 

public class prodottoDAO {

    public List<Prodotto> doRetrieveAll() throws SQLException {
        List<Prodotto> prodotti = new ArrayList<>();
        String sql = "SELECT * FROM prodotto";
        
        try (Connection con = connessione.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                prodotti.add(mapRowToProdotto(rs));
            }
        }
        return prodotti;
    }

    public Prodotto doRetrieveByKey(int id) throws SQLException {
        // Aggiornato con il nome colonna corretto idProdotto
        String sql = "SELECT * FROM prodotto WHERE idProdotto = ?";
        
        try (Connection con = connessione.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToProdotto(rs);
                }
            }
        }
        return null;
    }

    public List<Prodotto> doSearch(String query) throws SQLException {
        List<Prodotto> prodotti = new ArrayList<>();
        // Aggiornato con i nomi colonna corretti NomeProdotto e Descrizione
        String sql = "SELECT * FROM prodotto WHERE NomeProdotto LIKE ? OR Descrizione LIKE ?";
        
        try (Connection con = connessione.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            String searchPattern = "%" + query + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    prodotti.add(mapRowToProdotto(rs));
                }
            }
        }
        return prodotti;
    }

    private Prodotto mapRowToProdotto(ResultSet rs) throws SQLException {
        Prodotto p = new Prodotto();
        
        // Mappatura esatta basata sui nomi reali nel tuo database
        p.setIdProdotto(rs.getInt("idProdotto"));             
        p.setNomeProdotto(rs.getString("NomeProdotto"));      
        p.setDescrizione(rs.getString("Descrizione"));
        p.setPrezzoScontato(rs.getDouble("PrezzoScontato"));  
        p.setImmagine(rs.getString("Immagine"));      
        
        return p;
    }
}