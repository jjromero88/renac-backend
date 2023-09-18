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
    public class AsientoModificacionRepository : IAsientoModificacionRepository
    {
        private readonly DapperContext _context;
        private const string _schema = "renac";

        public AsientoModificacionRepository(DapperContext context)
        {
            _context = context;
        }

        public Response Insert(AsientoModificacion entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_asiento_modificacion_insertar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idasientocircunscripcion", entidad.idAsientoCircunscripcion);
                    parameters.Add("p_idtipomodificacionasiento", entidad.idTipoModificacionAsiento);
                    parameters.Add("p_usuarioreg", entidad.usuarioReg);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_error", dbType: DbType.Boolean, direction: ParameterDirection.Output);
                    parameters.Add("p_message", dbType: DbType.String, direction: ParameterDirection.Output, size: 500);

                    var result = connection.Execute(query, param: parameters, commandType: CommandType.StoredProcedure);

                    retorno.Error = parameters.Get<bool>("p_error");
                    retorno.Message = parameters.Get<string>("p_message");
                }
            }
            catch (Exception ex)
            {
                retorno.Error = true;
                retorno.Message = ex.Message;
            }

            return retorno;
        }

        public Response Update(AsientoModificacion entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_asiento_modificacion_actualizar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idasientomodificacion", entidad.idAsientoModificacion);
                    parameters.Add("p_idasientocircunscripcion", entidad.idAsientoCircunscripcion);
                    parameters.Add("p_idtipomodificacionasiento", entidad.idTipoModificacionAsiento);
                    parameters.Add("p_usuariomod", entidad.usuarioMod);
                    parameters.Add("p_error", dbType: DbType.Boolean, direction: ParameterDirection.Output);
                    parameters.Add("p_message", dbType: DbType.String, direction: ParameterDirection.Output, size: 500);

                    var result = connection.Execute(query, param: parameters, commandType: CommandType.StoredProcedure);

                    retorno.Error = parameters.Get<bool>("p_error");
                    retorno.Message = parameters.Get<string>("p_message");

                }
            }
            catch (Exception ex)
            {
                retorno.Error = true;
                retorno.Message = ex.Message;
            }

            return retorno;
        }

        public Response Delete(AsientoModificacion entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_asiento_modificacion_eliminar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idasientomodificacion", entidad.idAsientoModificacion);
                    parameters.Add("p_usuariomod", entidad.usuarioMod);
                    parameters.Add("p_error", dbType: DbType.Boolean, direction: ParameterDirection.Output);
                    parameters.Add("p_message", dbType: DbType.String, direction: ParameterDirection.Output, size: 500);

                    var result = connection.Execute(query, param: parameters, commandType: CommandType.StoredProcedure);

                    retorno.Error = parameters.Get<bool>("p_error");
                    retorno.Message = parameters.Get<string>("p_message");

                }
            }
            catch (Exception ex)
            {
                retorno.Error = true;
                retorno.Message = ex.Message;
            }

            return retorno;
        }

        public Response<dynamic> GetById(AsientoModificacion entidad)
        {
            Response<dynamic> retorno = new Response<dynamic>();
            var connection = _context.CreateConnection();

            try
            {
                using (var sqlConnection = new NpgsqlConnection(connection.ConnectionString))
                {
                    sqlConnection.Open();

                    var result = sqlConnection.QuerySingle<AsientoModificacion>($"SELECT * FROM {_schema}.fn_asiento_modificacion_seleccionar({entidad.idAsientoModificacion})");

                    retorno.Data = result;
                }
            }
            catch (Exception ex)
            {
                retorno.Error = true;
                retorno.Message = ex.Message;
            }

            return retorno;
        }

        public Response<List<dynamic>> GetList(AsientoModificacion entidad)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_asiento_modificacion_seleccionar", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add("@p_idasientomodificacion", NpgsqlDbType.Integer).Value = entidad.idAsientoModificacion == null ? 0 : (int)entidad.idAsientoModificacion;
                        command.Parameters.Add("@p_idasientocircunscripcion", NpgsqlDbType.Integer).Value = entidad.idAsientoCircunscripcion == null ? 0 : (int)entidad.idAsientoCircunscripcion;
                        command.Parameters.Add("@p_idtipomodificacionasiento", NpgsqlDbType.Integer).Value = entidad.idTipoModificacionAsiento == null ? 0 : (int)entidad.idTipoModificacionAsiento;

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

        public Response<List<dynamic>> GetListPaginated(AsientoModificacion entidad, out int PageSize, out int PageNumber, out int TotalReg)
        {
            Response<List<dynamic>> retorno = new Response<List<dynamic>>();
            int _PageSize = 0;
            int _PageNumber = 0;
            int _TotalReg = 0;

            try
            {
                var connection = _context.CreateConnection();

                using (var sqlConnection = new NpgsqlConnection(connection.ConnectionString))
                {
                    sqlConnection.Open();

                    using (var tran = sqlConnection.BeginTransaction())
                    {
                        var command = new NpgsqlCommand($"{_schema}.usp_asiento_modificacion_paginado", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        // Parámetros de entrada
                        command.Parameters.Add("@p_pagesize", NpgsqlDbType.Integer).Value = entidad.PageSize;
                        command.Parameters.Add("@p_pagenumber", NpgsqlDbType.Integer).Value = entidad.PageNumber;
                        command.Parameters.Add("@p_idasientomodificacion", NpgsqlDbType.Integer).Value = entidad.idAsientoModificacion == null ? 0 : (int)entidad.idAsientoModificacion;
                        command.Parameters.Add("@p_idasientocircunscripcion", NpgsqlDbType.Integer).Value = entidad.idAsientoCircunscripcion == null ? 0 : (int)entidad.idAsientoCircunscripcion;
                        command.Parameters.Add("@p_idtipomodificacionasiento", NpgsqlDbType.Integer).Value = entidad.idTipoModificacionAsiento == null ? 0 : (int)entidad.idTipoModificacionAsiento;

                        // Parámetros de salida
                        command.Parameters.Add("@p_totalreg", NpgsqlDbType.Integer).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@p_totpagina", NpgsqlDbType.Integer).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@p_numpagina", NpgsqlDbType.Integer).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@p_error", NpgsqlDbType.Boolean).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@p_message", NpgsqlDbType.Varchar, -1).Direction = ParameterDirection.Output;

                        var p_cursor = new NpgsqlParameter
                        {
                            ParameterName = "@p_cursor",
                            NpgsqlDbType = NpgsqlTypes.NpgsqlDbType.Refcursor,
                            Direction = ParameterDirection.InputOutput,
                            Value = "p_cursor"
                        };

                        command.Parameters.Add(p_cursor);

                        // Execute sql statement
                        command.ExecuteNonQuery();

                        // Leer el cursor
                        var cursor = p_cursor.Value.ToString();
                        var result = sqlConnection.Query<dynamic>($"FETCH ALL IN \"{cursor}\"", transaction: tran).ToList();

                        // Obtener los valores de los parámetros de salida
                        _PageSize = string.IsNullOrEmpty(command.Parameters["@p_totPagina"].Value?.ToString()) ? 0 : Convert.ToInt32(command.Parameters["@p_totPagina"].Value?.ToString());
                        _PageNumber = string.IsNullOrEmpty(command.Parameters["@p_numPagina"].Value?.ToString()) ? 0 : Convert.ToInt32(command.Parameters["@p_numPagina"].Value?.ToString());
                        _TotalReg = string.IsNullOrEmpty(command.Parameters["@p_totalReg"].Value?.ToString()) ? 0 : Convert.ToInt32(command.Parameters["@p_totalReg"].Value?.ToString());

                        // Seteamos los valores de retorno
                        retorno.Data = result;
                        retorno.Error = string.IsNullOrEmpty(command.Parameters["@p_error"].Value?.ToString()) ? false : Convert.ToBoolean(command.Parameters["@p_error"].Value?.ToString());
                        retorno.Message = command.Parameters["@p_message"].Value?.ToString();

                        tran.Commit();
                    }
                }

            }
            catch (Exception ex)
            {
                retorno.Error = true;
                retorno.Message = ex.Message;
            }
            finally
            {
                PageSize = _PageSize;
                PageNumber = _PageNumber;
                TotalReg = _TotalReg;
            }

            return retorno;
        }        
    }
}
