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
    public class ConstanciaAnotacionRepository : IConstanciaAnotacionRepository
    {
        private readonly DapperContext _context;
        private const string _schema = "renac";
        public ConstanciaAnotacionRepository(DapperContext context)
        {
            _context = context;
        }
        public Response Insert(ConstanciaAnotacion entidad)
        {
            throw new NotImplementedException();
        }

        public Response Update(ConstanciaAnotacion entidad)
        {
            throw new NotImplementedException();
        }

        public Response Delete(ConstanciaAnotacion entidad)
        {
            throw new NotImplementedException();
        }

        public Response<dynamic> GetById(ConstanciaAnotacion entidad)
        {
            throw new NotImplementedException();
        }

        public Response<List<dynamic>> GetList(ConstanciaAnotacion entidad)
        {
            throw new NotImplementedException();
        }

        public Response<List<dynamic>> GetListPaginated(ConstanciaAnotacion entidad, out int PageSize, out int PageNumber, out int TotalReg)
        {
            throw new NotImplementedException();
        }

        public Response<dynamic> GetConstanciaAnotacion(ConstanciaAnotacion entidad)
        {
            Response<dynamic> retorno = new Response<dynamic>();
            var connection = _context.CreateConnection();

            try
            {
                using (var sqlConnection = new NpgsqlConnection(connection.ConnectionString))
                {
                    sqlConnection.Open();

                    using (var tran = sqlConnection.BeginTransaction())
                    {
                        var command = new NpgsqlCommand($"{_schema}.usp_constancia_anotacion_renac", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add("@p_idinformerenac", NpgsqlDbType.Integer).Value = entidad.idInformeRenac == null ? 0 : (int)entidad.idInformeRenac;

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
                        var result = sqlConnection.QuerySingleOrDefault<dynamic>($"FETCH ALL IN \"{cursor}\"", transaction: tran);

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

        public Response<List<dynamic>> GetConstanciaAnotacionAsientos(ConstanciaAnotacion entidad)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_constancia_anotacion_renac_asientos", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add("@p_idinformerenac", NpgsqlDbType.Integer).Value = entidad.idInformeRenac == null ? 0 : (int)entidad.idInformeRenac;

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

    }
}
