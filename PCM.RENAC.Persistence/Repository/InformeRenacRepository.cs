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
    public class InformeRenacRepository : IInformeRenacRepository
    {
        private readonly DapperContext _context;
        private const string _schema = "renac";

        public InformeRenacRepository(DapperContext context)
        {
            _context = context;
        }

        public Response Insert(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_informe_renac_insertar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idcircunscripcion", entidad.idCircunscripcion);
                    parameters.Add("p_idestadoderivacion", entidad.idEstadoDerivacion);
                    parameters.Add("p_numero", entidad.numero);
                    parameters.Add("p_fecha", entidad.fecha == null ? (object)DBNull.Value : Convert.ToDateTime(entidad.fecha));
                    parameters.Add("p_descripcion", string.IsNullOrEmpty(entidad.descripcion) ? (object)null : entidad.descripcion);
                    parameters.Add("p_urlinformesustento", string.IsNullOrEmpty(entidad.urlinformesustento) ? DBNull.Value : entidad.urlinformesustento);
                    parameters.Add("p_nombreinformesustento", string.IsNullOrEmpty(entidad.nombreinformesustento) ? DBNull.Value : entidad.nombreinformesustento);
                    parameters.Add("p_evaluacionfavorable", entidad.evaluacionFavorable);
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

        public Response Update(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_informe_renac_actualizar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idinformerenac", entidad.idInformeRenac);
                    parameters.Add("p_idcircunscripcion", entidad.idCircunscripcion);
                    parameters.Add("p_idestadoderivacion", entidad.idEstadoDerivacion);
                    parameters.Add("p_numero", entidad.numero);
                    parameters.Add("p_fecha", entidad.fecha);
                    parameters.Add("p_descripcion", entidad.descripcion);
                    parameters.Add("p_urlinformesustento", entidad.urlinformesustento);
                    parameters.Add("p_nombreinformesustento", entidad.nombreinformesustento);
                    parameters.Add("p_evaluacionfavorable", entidad.evaluacionFavorable);
                    parameters.Add("p_usuariomod", entidad.usuarioReg);
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

        public Response Delete(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_informe_renac_eliminar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idinformerenac", entidad.idInformeRenac);
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

        public Response<dynamic> GetById(InformeRenac entidad)
        {
            Response<dynamic> retorno = new Response<dynamic>();
            var connection = _context.CreateConnection();

            try
            {
                using (var sqlConnection = new NpgsqlConnection(connection.ConnectionString))
                {
                    sqlConnection.Open();

                    var result = sqlConnection.QuerySingleOrDefault<dynamic>($"SELECT * FROM {_schema}.fn_informe_renac_seleccionar({entidad.idInformeRenac})");

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

        public Response<List<dynamic>> GetList(InformeRenac entidad)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_informe_renac_seleccionar", sqlConnection);
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

        public Response<List<dynamic>> GetListPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_informe_renac_paginado", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        // Parámetros de entrada
                        command.Parameters.Add("@p_pagesize", NpgsqlDbType.Integer).Value = entidad.PageSize;
                        command.Parameters.Add("@p_pagenumber", NpgsqlDbType.Integer).Value = entidad.PageNumber;
                        command.Parameters.Add("@p_filtro", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.filtro) ? DBNull.Value : entidad.filtro;

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

        public Response<List<dynamic>> GetListEspecialistaSsiatPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_especialista_ssiat_paginado", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        // Parámetros de entrada
                        command.Parameters.Add("@p_pagesize", NpgsqlDbType.Integer).Value = entidad.PageSize;
                        command.Parameters.Add("@p_pagenumber", NpgsqlDbType.Integer).Value = entidad.PageNumber;
                        command.Parameters.Add("@p_filtro", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.filtro) ? DBNull.Value : entidad.filtro;

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

        public Response<List<dynamic>> GetListSubsecretarioSsiatPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_subsecretario_ssiat_paginado", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        // Parámetros de entrada
                        command.Parameters.Add("@p_pagesize", NpgsqlDbType.Integer).Value = entidad.PageSize;
                        command.Parameters.Add("@p_pagenumber", NpgsqlDbType.Integer).Value = entidad.PageNumber;
                        command.Parameters.Add("@p_filtro", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.filtro) ? DBNull.Value : entidad.filtro;

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

        public Response<List<dynamic>> GetListSubsecretarioSsatdotPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_subsecretario_ssatdot_paginado", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        // Parámetros de entrada
                        command.Parameters.Add("@p_pagesize", NpgsqlDbType.Integer).Value = entidad.PageSize;
                        command.Parameters.Add("@p_pagenumber", NpgsqlDbType.Integer).Value = entidad.PageNumber;
                        command.Parameters.Add("@p_filtro", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.filtro) ? DBNull.Value : entidad.filtro;

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

        public Response<dynamic> GetListInformacionSsiatDocumentos(InformeRenac entidad)
        {
            Response<dynamic> retorno = new Response<dynamic>();
            var connection = _context.CreateConnection();

            try
            {
                using (var sqlConnection = new NpgsqlConnection(connection.ConnectionString))
                {
                    sqlConnection.Open();

                    var result = sqlConnection.QuerySingleOrDefault<dynamic>($"SELECT * FROM {_schema}.fn_informacion_ssiat_documentos({entidad.idInformeRenac})");

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

        public Response<List<dynamic>> GetListEspecialistaSsatdotPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_especialista_ssatdot_paginado", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        // Parámetros de entrada
                        command.Parameters.Add("@p_pagesize", NpgsqlDbType.Integer).Value = entidad.PageSize;
                        command.Parameters.Add("@p_pagenumber", NpgsqlDbType.Integer).Value = entidad.PageNumber;
                        command.Parameters.Add("@p_filtro", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.filtro) ? DBNull.Value : entidad.filtro;

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

        public Response UpdateEvaluacionFavorable(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_informe_renac_evaluacionfavorable";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idinformerenac", entidad.idInformeRenac);
                    parameters.Add("p_evaluacionfavorable", entidad.evaluacionFavorable);
                    parameters.Add("p_usuariomod", entidad.usuarioReg);
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

        public Response UpdateInformesOpinionFavorable(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_especialista_ssatdot_informefavorable";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_informefavorablearchivo", entidad.informeFavorableArchivo);
                    parameters.Add("p_informefavorablenumero", entidad.informeFavorableNumero);
                    parameters.Add("p_informefavorablefecha", entidad.informeFavorableFecha);
                    parameters.Add("p_listainformesrenac", entidad.listaInformesRenac);
                    parameters.Add("p_usuarioreg", entidad.usuarioReg);
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

        public Response<List<dynamic>> GetListSubsecretarioSsatdotDerivacionInformesPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_subsecretario_ssatdot_derivacioninformes_paginado", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        // Parámetros de entrada
                        command.Parameters.Add("@p_pagesize", NpgsqlDbType.Integer).Value = entidad.PageSize;
                        command.Parameters.Add("@p_pagenumber", NpgsqlDbType.Integer).Value = entidad.PageNumber;
                        command.Parameters.Add("@p_filtro", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.filtro) ? DBNull.Value : entidad.filtro;

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

        public Response VerificarInformeEvaluacionFavorable(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_informe_renac_verificar_informefavorable";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_listainformesrenac", entidad.listaInformesRenac);
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

        public Response<List<dynamic>> GetListResponsableArchivoSolicitudInformacionPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_responsablearchivo_solicitudinformacion_paginado", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        // Parámetros de entrada
                        command.Parameters.Add("@p_pagesize", NpgsqlDbType.Integer).Value = entidad.PageSize;
                        command.Parameters.Add("@p_pagenumber", NpgsqlDbType.Integer).Value = entidad.PageNumber;
                        command.Parameters.Add("@p_filtro", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.filtro) ? DBNull.Value : entidad.filtro;

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

        public Response UpdateSolicitudInformacion(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_responsablearchivo_solicitudinformacion_insertar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_oficiosolicitudnumero", entidad.oficioSolicitudNumero);
                    parameters.Add("p_oficiosolicitudfecha", entidad.oficioSolicitudFecha);
                    parameters.Add("p_oficiosolicitudarchivo", entidad.oficioSolicitudArchivo);
                    parameters.Add("p_evidenciasolicitudfecha", entidad.evidenciaSolicitudFecha);
                    parameters.Add("p_evidenciasolicitudarchivo", entidad.evidenciaSolicitudArchivo);
                    parameters.Add("p_listainformesrenac", entidad.listaInformesRenac);
                    parameters.Add("p_usuarioreg", entidad.usuarioReg);
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

        public Response<List<dynamic>> GetListEspecialistaSsiatRegistroFormatosPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_especialista_ssiat_registroformatos_paginado", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        // Parámetros de entrada
                        command.Parameters.Add("@p_pagesize", NpgsqlDbType.Integer).Value = entidad.PageSize;
                        command.Parameters.Add("@p_pagenumber", NpgsqlDbType.Integer).Value = entidad.PageNumber;
                        command.Parameters.Add("@p_filtro", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.filtro) ? DBNull.Value : entidad.filtro;

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

        public Response UpdateConstanciaAnotacion(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_especialista_ssiat_registrarconstancia";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idinformerenac", entidad.idInformeRenac);
                    parameters.Add("p_constanciaanotacionarchivo", entidad.constanciaAnotacionArchivo);
                    parameters.Add("p_usuariomod", entidad.usuarioReg);
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

        public Response UpdateRespuestaGore(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_especialista_ssiat_respuestagore";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_respuestagorearchivo", entidad.respuestaGoreArchivo);
                    parameters.Add("p_respuestagorenumero", entidad.respuestaGoreNumero);
                    parameters.Add("p_respuestagorefecha", entidad.respuestaGoreFecha);
                    parameters.Add("p_listainformesrenac", entidad.listaInformesRenac);
                    parameters.Add("p_usuarioreg", entidad.usuarioReg);
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

        public Response<List<dynamic>> GetListSubsecretarioSsiatRegistroAnotacionPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_subsecretario_ssiat_anotacion_paginado", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        // Parámetros de entrada
                        command.Parameters.Add("@p_pagesize", NpgsqlDbType.Integer).Value = entidad.PageSize;
                        command.Parameters.Add("@p_pagenumber", NpgsqlDbType.Integer).Value = entidad.PageNumber;
                        command.Parameters.Add("@p_filtro", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.filtro) ? DBNull.Value : entidad.filtro;

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

        public Response UpdateRegistroAnotacion(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_responsablearchivo_registroanotacion_insertar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_oficioanotacionnumero", entidad.oficioAnotacionNumero);
                    parameters.Add("p_oficioanotacionfecha", entidad.oficioAnotacionFecha);
                    parameters.Add("p_oficioanotacionarchivo", entidad.oficioAnotacionArchivo);
                    parameters.Add("p_evidenciaanotacionfecha", entidad.evidenciaAnotacionFecha);
                    parameters.Add("p_evidenciaanotacionarchivo", entidad.evidenciaAnotacionArchivo);
                    parameters.Add("p_listainformesrenac", entidad.listaInformesRenac);
                    parameters.Add("p_usuarioreg", entidad.usuarioReg);
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

        public Response UpdateConstanciaAnotacionFirmada(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_subsecretario_ssiat_registrarconstancia";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idinformerenac", entidad.idInformeRenac);
                    parameters.Add("p_constanciaanotacionfirmadafecha", entidad.constanciaAnotacionFirmadaFecha);
                    parameters.Add("p_constanciaanotacionfirmadaarchivo", entidad.constanciaAnotacionFirmadaArchivo);
                    parameters.Add("p_usuariomod", entidad.usuarioReg);
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

        public Response<List<dynamic>> GetListResponsableArchivoRegistroAnotacionPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_responsable_archivo_anotacion_paginado", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        // Parámetros de entrada
                        command.Parameters.Add("@p_pagesize", NpgsqlDbType.Integer).Value = entidad.PageSize;
                        command.Parameters.Add("@p_pagenumber", NpgsqlDbType.Integer).Value = entidad.PageNumber;
                        command.Parameters.Add("@p_filtro", NpgsqlDbType.Varchar, int.MaxValue).Value = string.IsNullOrEmpty(entidad.filtro) ? DBNull.Value : entidad.filtro;

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

        public Response UpdateCerrarProcesoAnotacion(InformeRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_responsable_archivo_cerraranotacion";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_listainformes", entidad.listaInformesRenac);
                    parameters.Add("p_usuariomod", entidad.usuarioReg);
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
    }
}
