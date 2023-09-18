using Microsoft.Extensions.Configuration;
using Npgsql;
using System.Data;

namespace PCM.RENAC.Persistence.Context
{
    public class DapperContext
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public DapperContext(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = configuration.GetConnectionString("RENACConnectionSettings");
        }

        public IDbConnection CreateConnection() => new NpgsqlConnection(_connectionString);
    }
}
