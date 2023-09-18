using Dapper;
using Npgsql;
using NpgsqlTypes;
using PCM.RENAC.Application.Interface.Persistence;
using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Persistence.Context;
using PCM.RENAC.Transversal.Common;
using System.Data;

namespace PCM.RENAC.Persistence.Repository
{
    public class CircunscripcionRepository : ICircunscripcionRepository
    {
        private readonly DapperContext _context;
        private const string _schema = "renac";

        public CircunscripcionRepository(DapperContext context)
        {
            _context = context;
        }

        public Response Delete(Circunscripcion entidad)
        {
            throw new NotImplementedException();
        }

        public Response<dynamic> GetById(Circunscripcion entidad)
        {
            throw new NotImplementedException();
        }

        public Response<List<dynamic>> GetList(Circunscripcion entidad)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_circunscripcion_seleccionar", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add("@p_codcircunscripcion", NpgsqlDbType.Integer).Value = entidad.CodCircunscripcion == null ? 0 : (int)entidad.CodCircunscripcion;
                        command.Parameters.Add("@p_tipcircunscripcion", NpgsqlDbType.Integer).Value = entidad.TipCircunscripcion == null ? 0 : (int)entidad.TipCircunscripcion;                      
                        command.Parameters.Add("@p_nomcircunscripcion", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.NomCircunscripcion) ? DBNull.Value : entidad.NomCircunscripcion;

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

        public Response<List<dynamic>> GetListPaginated(Circunscripcion entidad, out int PageSize, out int PageNumber, out int TotalReg)
        {
            throw new NotImplementedException();
        }

        public Response Insert(Circunscripcion entidad)
        {
            throw new NotImplementedException();
        }

        public Response Update(Circunscripcion entidad)
        {
            throw new NotImplementedException();
        }
    }
}
