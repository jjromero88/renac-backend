using Dapper;
using Npgsql;
using PCM.RENAC.Application.Interface.Persistence;
using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Persistence.Context;
using PCM.RENAC.Transversal.Common;
using System.Data;

namespace PCM.RENAC.Persistence.Repository
{
    public class TipoDispositivoRepository : ITipoDispositivoRepository
    {
        private readonly DapperContext _context;
        private const string _schema = "renac";

        public TipoDispositivoRepository(DapperContext context)
        {
            _context = context;
        }

        public Response Insert(TipoDispositivo entidad)
        {
            throw new NotImplementedException();
        }

        public Response Update(TipoDispositivo entidad)
        {
            throw new NotImplementedException();
        }

        public Response Delete(TipoDispositivo entidad)
        {
            throw new NotImplementedException();
        }

        public Response<dynamic> GetById(TipoDispositivo entidad)
        {
            throw new NotImplementedException();
        }

        public Response<List<dynamic>> GetList(TipoDispositivo entidad)
        {
            Response<List<dynamic>> retorno = new Response<List<dynamic>>();
            var connection = _context.CreateConnection();

            try
            {
                using (var sqlConnection = new NpgsqlConnection(connection.ConnectionString))
                {
                    sqlConnection.Open();
                    using (var tran = sqlConnection.BeginTransaction())
                    {
                        var command = new NpgsqlCommand($"{_schema}.usp_tipo_dispositivo_seleccionar", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        var p_cursor = new NpgsqlParameter
                        {
                            ParameterName = "@p_cursor",
                            NpgsqlDbType = NpgsqlTypes.NpgsqlDbType.Refcursor,
                            Direction = ParameterDirection.InputOutput,
                            Value = "p_cursor"
                        };

                        command.Parameters.Add(p_cursor);

                        command.ExecuteNonQuery();

                        var cursor = p_cursor.Value.ToString();

                        var result = sqlConnection.Query<dynamic>($"FETCH ALL IN \"{cursor}\"", transaction: tran).ToList();

                        retorno.Data = result;

                        tran.Commit();
                    }
                }
            }
            catch (Exception ex)
            {
                retorno.Error = true;
                retorno.Message = ex.Message;
            }

            return retorno;
        }

        public Response<List<dynamic>> GetListPaginated(TipoDispositivo entidad, out int PageSize, out int PageNumber, out int TotalReg)
        {
            throw new NotImplementedException();
        }       
    }
}
