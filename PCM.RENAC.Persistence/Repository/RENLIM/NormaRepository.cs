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
    public class NormaRepository : INormaRepository
    {
        private readonly DapperContext _context;
        private const string _schema = "renac";

        public NormaRepository(DapperContext context)
        {
            _context = context;
        }

        public Response Insert(Norma entidad)
        {
            throw new NotImplementedException();
        }

        public Response Update(Norma entidad)
        {
            throw new NotImplementedException();
        }

        public Response Delete(Norma entidad)
        {
            throw new NotImplementedException();
        }

        public Response<dynamic> GetById(Norma entidad)
        {
            throw new NotImplementedException();
        }

        public Response<List<dynamic>> GetList(Norma entidad)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_norma_seleccionar", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add("@p_codnorma", NpgsqlDbType.Integer).Value = entidad.CodNorma == null ? 0 : (int)entidad.CodNorma;
                        command.Parameters.Add("@p_tipo", NpgsqlDbType.Integer).Value = entidad.Tipo == null ? 0 : (int)entidad.Tipo;
                        command.Parameters.Add("@p_numero", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.Numero) ? DBNull.Value : entidad.Numero;
                        command.Parameters.Add("@p_fecha", NpgsqlDbType.Date).Value = !entidad.Fecha.HasValue ? DBNull.Value : entidad.Fecha.Value;

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

        public Response<List<dynamic>> GetListPaginated(Norma entidad, out int PageSize, out int PageNumber, out int TotalReg)
        {
            throw new NotImplementedException();
        }      
    }
}
