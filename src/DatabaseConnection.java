import java.io.FileInputStream;
import java.sql.*;
import java.util.Properties;

public class DatabaseConnection {
    public static void main(String[] args) {
        try {
            // Charger le driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
           // charger le fichier de configuration
            Properties props=new Properties();
            FileInputStream fil=new FileInputStream("config.properties");
            props.load(fil);

            // Connexion à la base (adapter nom, utilisateur et mot de passe)
            String url=props.getProperty("db.url");
            String user=props.getProperty("db.user");
            String password=props.getProperty("db.password");
            System.out.println("url: "+ url);
            Connection con = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Connexion réussie !");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * from plantes");

            //Traitement des colonnes d'une table

            ResultSetMetaData rsMetaData= (ResultSetMetaData)  rs.getMetaData();
            //recuperer le nombre de colonnes de la table
            int nCols=rsMetaData.getColumnCount();
            System.out.println("nCols: " + nCols);
            //recuperer les noms de ces colonnes
            String [] resColNames= new String[nCols];
            for( int c=1;c<=nCols; c++){
                String el=rsMetaData.getColumnLabel(c);
                //System.out.println("el : "+ el);
                resColNames[c-1]=el;
            }

            while (rs.next()) {
                System.out.println(rs.getInt("id_plante") + " - " + rs.getString("nom_plante"));
            }

            // Fermer la connexion
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println(e);
        }
    }
}
