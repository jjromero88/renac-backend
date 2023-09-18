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
    public class DerivacionRenacRepository : IDerivacionRenacRepository
    {
        private readonly DapperContext _context;
        private const string _schema = "renac";

        public DerivacionRenacRepository(DapperContext context)
        {
            _context = context;
        }
        public Response Insert(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_derivacion_renac_insertar";

                    var parameters = new DynamicParameters();

                    parameters.Add("p_idderivacionorigen", entidad.idDerivacionOrigen);
                    parameters.Add("p_idderivaciondestino", entidad.idDerivacionDestino);
                    parameters.Add("p_idespecialistassatdot", entidad.idEspecialistaSsatdot);
                    parameters.Add("p_fechaderivacion", entidad.fechaDerivacion);
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_observacion", entidad.observacion);
                    parameters.Add("p_esretorno", entidad.esRetorno);
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

        public Response Update(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_derivacion_renac_actualizar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idderivacionrenac", entidad.idDerivacionRenac);
                    parameters.Add("p_idderivacionorigen", entidad.idDerivacionOrigen);
                    parameters.Add("p_idderivaciondestino", entidad.idDerivacionDestino);
                    parameters.Add("p_idespecialistassatdot", entidad.idEspecialistaSsatdot);
                    parameters.Add("p_fechaderivacion", entidad.fechaDerivacion);
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_observacion", entidad.observacion);
                    parameters.Add("p_esretorno", entidad.esRetorno);
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

        public Response Delete(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_derivacion_renac_eliminar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idderivacionrenac", entidad.idDerivacionRenac);
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

        public Response<dynamic> GetById(DerivacionRenac entidad)
        {
            Response<dynamic> retorno = new Response<dynamic>();
            var connection = _context.CreateConnection();

            try
            {
                using (var sqlConnection = new NpgsqlConnection(connection.ConnectionString))
                {
                    sqlConnection.Open();

                    var result = sqlConnection.QuerySingleOrDefault<dynamic>($"SELECT * FROM {_schema}.fn_derivacion_renac_seleccionar({entidad.idDerivacionRenac})");

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

        public Response<List<dynamic>> GetList(DerivacionRenac entidad)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_derivacion_renac_seleccionar", sqlConnection);
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add("@p_idderivacionrenac", NpgsqlDbType.Integer).Value = entidad.idDerivacionRenac == null ? 0 : (int)entidad.idDerivacionRenac;

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

        public Response<List<dynamic>> GetListPaginated(DerivacionRenac entidad, out int PageSize, out int PageNumber, out int TotalReg)
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
                        var command = new NpgsqlCommand($"{_schema}.usp_derivacion_renac_paginado", sqlConnection);
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

        public Response DerivacionEspecialistaSSIAT(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_especialista_ssiat_derivar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);
                    parameters.Add("p_rutadocumentomemo", entidad.documentoMemoRuta);
                    parameters.Add("p_nombredocumentomemo", entidad.documentoMemoNombre);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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

        public Response DerivacionSubsecretarioSSIAT(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_subsecretario_ssiat_derivar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);
                    parameters.Add("p_idtipodocumento", entidad.idTipoDocumento);
                    parameters.Add("p_rutadocumentomemo", entidad.documentoMemoRuta);
                    parameters.Add("p_nombredocumentomemo", entidad.documentoMemoNombre);
                    parameters.Add("p_numerodocumento", entidad.numeroDocumento);
                    parameters.Add("p_fechadocumento", entidad.fechaDocumento);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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

        public Response DerivacionAjustesSubsecretarioSSIAT(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_subsecretario_ssiat_ajustes";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_observaciones", entidad.observacion);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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

        public Response DerivacionSubsecretarioSSATDOT(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_subsecretario_ssatdot_derivar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_idespecialista", entidad.idEspecialistaSsatdot);
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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

        public Response DerivacionEspecialistaSSATDOT(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_especialista_ssatdot_derivar";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);
                    parameters.Add("p_rutadocumentomemo", entidad.documentoMemoRuta);
                    parameters.Add("p_nombredocumentomemo", entidad.documentoMemoNombre);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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

        public Response DerivacionAjustesEspecialistaSSATDOT(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_especialista_ssatdot_ajustes";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_observaciones", entidad.observacion);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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

        public Response DerivacionAjustesSubsecretarioSSATDOT(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_subsecretario_ssatdot_ajustes";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_observaciones", entidad.observacion);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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

        public Response DerivacionInformesSubsecretarioSSATDOT(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_subsecretario_ssatdot_derivacioninformes";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);
                    parameters.Add("p_idtipodocumentorenac", entidad.idTipoDocumento);
                    parameters.Add("p_rutadocumento", entidad.documentoMemoRuta);
                    parameters.Add("p_nombredocumento", entidad.documentoMemoNombre);
                    parameters.Add("p_fechadocumento", entidad.fechaDocumento);
                    parameters.Add("p_numerodocumento", entidad.numeroDocumento);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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

        public Response DerivacionInformesResponsableArchivo(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_responsable_archivo_derivarsolicitud";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);                   
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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

        public Response DerivacionModificacionEspecialistaSSIAT(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_especialista_ssiat_retornomodificacion";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_observaciones", entidad.observacion);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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

        public Response DerivacionParaAnotacionEspecialistaSSIAT(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_especialista_ssiat_derivar_anotacion";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);
                    parameters.Add("p_rutadocumento", entidad.documentoMemoRuta);
                    parameters.Add("p_nombredocumento", entidad.documentoMemoNombre);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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

        public Response DerivacionParaAnotacionSubsecretarioSSIAT(DerivacionRenac entidad)
        {
            Response retorno = new Response();

            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var query = $"{_schema}.usp_subsecretario_ssiat_derivar_anotacion";

                    var parameters = new DynamicParameters();
                    parameters.Add("p_usuarioorigen", entidad.usuarioOrigen);
                    parameters.Add("p_usuariodestino", entidad.usuarioDestino);
                    parameters.Add("p_esretorno", entidad.esRetorno);
                    parameters.Add("p_derivacioninformes", entidad.derivacioninformes);
                    parameters.Add("p_rutadocumento", entidad.documentoMemoRuta);
                    parameters.Add("p_nombredocumento", entidad.documentoMemoNombre);
                    parameters.Add("p_fechadocumento", entidad.fechaDocumento);
                    parameters.Add("p_numerodocumento", entidad.numeroDocumento);
                    parameters.Add("p_activo", entidad.activo);
                    parameters.Add("p_usuarioreg", entidad.usuarioMod);
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
