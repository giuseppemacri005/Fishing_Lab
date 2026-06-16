package model;

import java.io.Serializable;

public class Prodotto implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int idProdotto;
    private String nomeProdotto;
    private String descrizione;
    private double prezzoOriginale;
    private double prezzoScontato;
    private int annoProduzione;
    private String nomeBrand; // Recuperato tramite la JOIN SQL con la tabella Brand
    private String immagine;

    // Costruttore vuoto obbligatorio per lo standard JavaBean
    public Prodotto() {}

    // Metodi Getter e Setter
    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }

    public String getNomeProdotto() { return nomeProdotto; }
    public void setNomeProdotto(String nomeProdotto) { this.nomeProdotto = nomeProdotto; }

    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }

    public double getPrezzoOriginale() { return prezzoOriginale; }
    public void setPrezzoOriginale(double prezzoOriginale) { this.prezzoOriginale = prezzoOriginale; }

    public double getPrezzoScontato() { return prezzoScontato; }
    public void setPrezzoScontato(double prezzoScontato) { this.prezzoScontato = prezzoScontato; }

    public int getAnnoProduzione() { return annoProduzione; }
    public void setAnnoProduzione(int annoProduzione) { this.annoProduzione = annoProduzione; }

    public String getNomeBrand() { return nomeBrand; }
    public void setNomeBrand(String nomeBrand) { this.nomeBrand = nomeBrand; }
    
    public String getImmagine() { return this.immagine; }
    public void setImmagine(String immagine) { this.immagine = immagine; }
}