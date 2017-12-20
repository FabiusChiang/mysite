using MySql.Data.MySqlClient;
using System;

namespace CSConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            var server = "localhost";
            var database = "testdb";
            var uid = "root";
            var password = "12345";
            string connectionString = $"SERVER={server};DATABASE={database};UID={uid};PASSWORD={password};";

            var conn = new MySqlConnection(connectionString);
            conn.Open();

            string query = "SELECT * FROM test_table_01";
            var cmd = new MySqlCommand(query, conn);
            var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                string column0 = reader.GetString(0);
                string column1 = reader.GetString(1);
                Console.WriteLine(column0 + "," + column1);
            }


            conn.Close();
        }
    }
}
