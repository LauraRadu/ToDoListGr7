package ir;

import login.DBOper;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class SingleListPersons {

    private List<ToDoItem> listofNames = new ArrayList<>();
    private List<ToDoItem> listofDone = new ArrayList<>();

    public void addInTheListOfNames(ToDoItem s, int fkuser) throws ClassNotFoundException, SQLException {

        if (s.getName()!=null && s.getName().trim().length() > 0 ) {
            Class.forName("org.postgresql.Driver");


            Connection conn = DriverManager.getConnection(DBOper.URL, DBOper.USERNAME, DBOper.PASSWORD);

            PreparedStatement pSt = conn.prepareStatement("INSERT INTO todoitems (name, done, fkuser) VALUES (?,?, ?)");
            pSt.setString(1, s.getName());
            pSt.setInt(2, s.getDone());
            pSt.setInt(3, fkuser);

            int rowsInserted = pSt.executeUpdate();

            pSt.close();
            conn.close();
        }
    }

    public List getListOfNames(int iduser) throws ClassNotFoundException, SQLException{

        Class.forName("org.postgresql.Driver");

        Connection conn = DriverManager.getConnection(DBOper.URL, DBOper.USERNAME, DBOper.PASSWORD);

        PreparedStatement pSt = conn.prepareStatement("SELECT id, name, prioritytask FROM todoitems where fkuser="+iduser+" and done=0");
        ResultSet rs = pSt.executeQuery();
        while(rs.next()) {
            ToDoItem ir = new ToDoItem();
            ir.setId(rs.getInt("id"));
            ir.setName(rs.getString("name"));
            ir.setPrioritytask(rs.getInt("prioritytask"));
            listofNames.add(ir);
        }

        pSt.close();
        conn.close();

        return listofNames;
    }

    public void markDone(int id, int fkuser) throws ClassNotFoundException, SQLException {

        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(DBOper.URL, DBOper.USERNAME, DBOper.PASSWORD);

        PreparedStatement pSt = conn.prepareStatement("UPDATE todoitems SET DONE=1 WHERE ID=? and fkuser=?");
        pSt.setInt(1, id);
        pSt.setInt(2, fkuser);

        int rowsInserted = pSt.executeUpdate();

        pSt.close();
        conn.close();
    }

    public List getListOfDone(int iduser) throws ClassNotFoundException, SQLException{

        Class.forName("org.postgresql.Driver");

        Connection conn = DriverManager.getConnection(DBOper.URL, DBOper.USERNAME, DBOper.PASSWORD);

        PreparedStatement pSt = conn.prepareStatement("SELECT id, name FROM todoitems where fkuser="+iduser+" and done=1");
        ResultSet rs = pSt.executeQuery();

        while(rs.next()) {
            ToDoItem ir = new ToDoItem();
            ir.setId(rs.getInt("id"));
            ir.setName(rs.getString("name"));
            listofDone.add(ir);
        }

        pSt.close();
        conn.close();

        return listofDone;
    }

    public void markUndone(int idtask, int fkuser)  throws ClassNotFoundException, SQLException{
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(DBOper.URL, DBOper.USERNAME, DBOper.PASSWORD);

        PreparedStatement pSt = conn.prepareStatement("UPDATE todoitems SET DONE=0 WHERE ID=? and fkuser=?");
        pSt.setInt(1, idtask);
        pSt.setInt(2, fkuser);

        int rowsInserted = pSt.executeUpdate();
        pSt.close();
        conn.close();
    }

    public void markPriority(int idtask, int fkuser)   throws ClassNotFoundException, SQLException{
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(DBOper.URL, DBOper.USERNAME, DBOper.PASSWORD);

        PreparedStatement pSt = conn.prepareStatement("UPDATE todoitems SET prioritytask=1 WHERE ID=? and fkuser=?");
        pSt.setInt(1, idtask);
        pSt.setInt(2, fkuser);

        int rowsInserted = pSt.executeUpdate();
        pSt.close();
        conn.close();
    }

    public void unmarkPriority(int idtask, int fkuser)  throws ClassNotFoundException, SQLException {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(DBOper.URL, DBOper.USERNAME, DBOper.PASSWORD);

        PreparedStatement pSt = conn.prepareStatement("UPDATE todoitems SET prioritytask=0 WHERE ID=? and fkuser=?");
        pSt.setInt(1, idtask);
        pSt.setInt(2, fkuser);

        int rowsInserted = pSt.executeUpdate();
        pSt.close();
        conn.close();
    }
}



