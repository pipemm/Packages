package demo;

import java.sql.ResultSet;
import java.sql.SQLException;

interface IWriter {

    public void write(ResultSet rs) throws SQLException;

}