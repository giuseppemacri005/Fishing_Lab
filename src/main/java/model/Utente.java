package model; // Il pacchetto dedicato ai modelli della tua applicazione

public class Utente {
    // Variabili d'istanza private (Incapsulamento)
    private String nome;
    private String cognome;
    private String email;
    private String password;

    /**
     * Costruttore vuoto (di default).
     * È fondamentale nelle specifiche Java Bean per permettere la creazione dell'oggetto 
     * anche senza passare subito i parametri.
     */
    public Utente() {
    }

    /**
     * Costruttore completo.
     * Permette di istanziare l'utente e popolarlo immediatamente con tutti i dati del form.
     */
    public Utente(String nome, String cognome, String email, String password) {
        this.nome = nome;
        this.cognome = cognome;
        this.email = email;
        this.password = password;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Metodo toString (Opzionale ma molto utile per il Debug).
     * Ti permette di stampare in console l'oggetto per vedere se i dati sono corretti,
     * es: System.out.println(utente);
     * NOTA: Per motivi di sicurezza, non stampiamo mai la password nel toString.
     */
    @Override
    public String toString() {
        return "Utente{" +
                "nome='" + nome + '\'' +
                ", cognome='" + cognome + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}