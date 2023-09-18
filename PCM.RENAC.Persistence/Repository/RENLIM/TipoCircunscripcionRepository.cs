using Dapper;
using Npgsql;
using PCM.RENAC.Application.Interface.Persistence;
using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Persistence.Context;
using PCM.RENAC.Transversal.Common;
using System.Data;

namespace PCM.RENAC.Persistence.Repository
{
    public class TipoCircunscripcionRepository : ITipoCircunscripcionRepository
    {
        private readonly DapperContext _context;
        private const string _schema = "renac";

        public TipoCircunscripcionRepository(DapperContext context)
        {
            _context = context;
        }

        public Response Insert(TipoCircunscripcion entidad)
        {
            throw new NotImplementedException();
        }

        public Response Update(TipoCircunscripcion entidad)
        {
            throw new NotImplementedException();
        }

        public Response Delete(TipoCircunscripcion entidad)
        {
            throw new NotImplementedException();
        }

        public Response<dynamic> GetById(TipoCircunscripcion entidad)
        {
            throw new NotImplementedException();
        }

        public Response<List<dynamic>> GetList(TipoCircunscripcion entidad)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_tipo_circunscripcion_seleccionar", sqlConnection);
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

        public Response<List<dynamic>> GetListPaginated(TipoCircunscripcion entidad, out int PageSize, out int PageNumber, out int TotalReg)
        {
            throw new NotImplementedException();
        }
       
    }
}
