using AutoMapper;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Domain.Entities;

namespace PCM.RENAC.Transversal.Mapper
{
    public class MappingsProfile : Profile
    {
        public MappingsProfile()
        {

            #region TipoAsiento

            CreateMap<TipoAsiento, TipoAsientoDto>().ReverseMap()
              .ForMember(destination => destination.idTipoAsiento, source => source.MapFrom(src => src.idTipoAsiento))
              .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
              .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
              .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
              .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
              .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
              .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
              .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
              .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod));

            CreateMap<TipoAsientoDto, TipoAsientoInsertRequest>().ReverseMap()
              .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
              .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion));

            CreateMap<TipoAsientoDto, TipoAsientoUpdateRequest>().ReverseMap()
              .ForMember(destination => destination.idTipoAsiento, source => source.MapFrom(src => src.idTipoAsiento))
              .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
              .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion));

            CreateMap<TipoAsientoDto, TipoAsientoFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.idTipoAsiento, source => source.MapFrom(src => src.idTipoAsiento))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<TipoAsientoDto, TipoAsientoPaginacionFiltroRequest>().ReverseMap()
               .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
               .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
               .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
               .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<TipoAsientoDto, TipoAsientoIdRequest>().ReverseMap()
              .ForMember(destination => destination.idTipoAsiento, source => source.MapFrom(src => src.idTipoAsiento));

            CreateMap<TipoAsientoDto, TipoAsientoResponse>().ReverseMap()
             .ForMember(destination => destination.idTipoAsiento, source => source.MapFrom(src => src.idTipoAsiento))
             .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
             .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
             .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo));

            #endregion

            #region InformeRenac

            CreateMap<InformeRenac, InformeRenacDto>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.fecha, source => source.MapFrom(src => src.fecha))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.urlinformesustento, source => source.MapFrom(src => src.urlinformesustento))
                .ForMember(destination => destination.nombreinformesustento, source => source.MapFrom(src => src.nombreinformesustento))
                .ForMember(destination => destination.evaluacionFavorable, source => source.MapFrom(src => src.evaluacionFavorable))
                .ForMember(destination => destination.solicitudGore, source => source.MapFrom(src => src.solicitudGore))
                .ForMember(destination => destination.informeFavorableArchivo, source => source.MapFrom(src => src.informeFavorableArchivo))
                .ForMember(destination => destination.informeFavorableNumero, source => source.MapFrom(src => src.informeFavorableNumero))
                .ForMember(destination => destination.informeFavorableFecha, source => source.MapFrom(src => src.informeFavorableFecha))
                .ForMember(destination => destination.fechaSolicitudInformacion, source => source.MapFrom(src => src.fechaSolicitudInformacion))
                .ForMember(destination => destination.oficioSolicitudNumero, source => source.MapFrom(src => src.oficioSolicitudNumero))
                .ForMember(destination => destination.oficioSolicitudFecha, source => source.MapFrom(src => src.oficioSolicitudFecha))
                .ForMember(destination => destination.oficioSolicitudArchivo,  source => source.MapFrom(src => src.oficioSolicitudArchivo))
                .ForMember(destination => destination.evidenciaSolicitudFecha, source => source.MapFrom(src => src.evidenciaSolicitudFecha))
                .ForMember(destination => destination.evidenciaSolicitudArchivo, source => source.MapFrom(src => src.evidenciaSolicitudArchivo))
                .ForMember(destination => destination.oficioAnotacionNumero, source => source.MapFrom(src => src.oficioAnotacionNumero))
                .ForMember(destination => destination.oficioAnotacionFecha, source => source.MapFrom(src => src.oficioAnotacionFecha))
                .ForMember(destination => destination.oficioAnotacionArchivo, source => source.MapFrom(src => src.oficioAnotacionArchivo))
                .ForMember(destination => destination.evidenciaAnotacionFecha, source => source.MapFrom(src => src.evidenciaAnotacionFecha))
                .ForMember(destination => destination.evidenciaAnotacionArchivo, source => source.MapFrom(src => src.evidenciaAnotacionArchivo))
                .ForMember(destination => destination.constanciaAnotacionArchivo, source => source.MapFrom(src => src.constanciaAnotacionArchivo))
                .ForMember(destination => destination.constanciaAnotacionFirmadaFecha, source => source.MapFrom(src => src.constanciaAnotacionFirmadaFecha))
                .ForMember(destination => destination.constanciaAnotacionFirmadaArchivo, source => source.MapFrom(src => src.constanciaAnotacionFirmadaArchivo))
                .ForMember(destination => destination.respuestaGoreNumero, source => source.MapFrom(src => src.respuestaGoreNumero))
                .ForMember(destination => destination.respuestaGoreFecha, source => source.MapFrom(src => src.respuestaGoreFecha))
                .ForMember(destination => destination.respuestaGoreArchivo, source => source.MapFrom(src => src.respuestaGoreArchivo))
                .ForMember(destination => destination.archivado, source => source.MapFrom(src => src.archivado))
                .ForMember(destination => destination.procesoAnotacionCerrado, source => source.MapFrom(src => src.procesoAnotacionCerrado))
                .ForMember(destination => destination.estadoDerivacion, source => source.MapFrom(src => src.estadoDerivacion))
                .ForMember(destination => destination.estadoSsiat, source => source.MapFrom(src => src.estadoSsiat))
                .ForMember(destination => destination.estadoAnotacion, source => source.MapFrom(src => src.estadoAnotacion))
                .ForMember(destination => destination.urlProyectoMemoEspSsiat, source => source.MapFrom(src => src.urlProyectoMemoEspSsiat))
                .ForMember(destination => destination.urlProyectoMemoSubSsiat, source => source.MapFrom(src => src.urlProyectoMemoSubSsiat))
                .ForMember(destination => destination.urlRespuestaGore, source => source.MapFrom(src => src.urlRespuestaGore))
                .ForMember(destination => destination.esDerivado, source => source.MapFrom(src => src.esDerivado))
                .ForMember(destination => destination.solicitudDiasTranscurridos, source => source.MapFrom(src => src.solicitudDiasTranscurridos))
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
                .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
                .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
                .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod))
                .ForMember(destination => destination.listaInformesRenac, source => source.MapFrom(src => src.listaInformesRenac))
                .ForMember(destination => destination.Circunscripcion, source => source.MapFrom(src => src.Circunscripcion));

            CreateMap<InformeRenacDto, InformeRenacInsertRequest>().ReverseMap()
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.fecha, source => source.MapFrom(src => src.fecha))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.InformeAnotacionBase64, source => source.MapFrom(src => src.InformeAnotacionBase64));

            CreateMap<InformeRenacDto, InformeRenacUpdateRequest>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.fecha, source => source.MapFrom(src => src.fecha))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.InformeAnotacionBase64, source => source.MapFrom(src => src.InformeAnotacionBase64));

            CreateMap<InformeRenacDto, InformeRenacFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeRenacDto, InformeRenacPaginacionFiltroRequest>().ReverseMap()
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeRenacDto, InformeRenacIdRequest>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac));

            CreateMap<InformeRenacDto, InformeRenacResponse>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.fecha, source => source.MapFrom(src => src.fecha))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.urlinformesustento, source => source.MapFrom(src => src.urlinformesustento))
                .ForMember(destination => destination.nombreinformesustento, source => source.MapFrom(src => src.nombreinformesustento))
                .ForMember(destination => destination.evaluacionFavorable, source => source.MapFrom(src => src.evaluacionFavorable))
                .ForMember(destination => destination.fechaSolicitudInformacion, source => source.MapFrom(src => src.fechaSolicitudInformacion))
                .ForMember(destination => destination.oficioSolicitudNumero, source => source.MapFrom(src => src.oficioSolicitudNumero))
                .ForMember(destination => destination.oficioSolicitudFecha, source => source.MapFrom(src => src.oficioSolicitudFecha))
                .ForMember(destination => destination.oficioSolicitudArchivo, source => source.MapFrom(src => src.oficioSolicitudArchivo))
                .ForMember(destination => destination.evidenciaSolicitudFecha, source => source.MapFrom(src => src.evidenciaSolicitudFecha))
                .ForMember(destination => destination.evidenciaSolicitudArchivo, source => source.MapFrom(src => src.evidenciaSolicitudArchivo))
                .ForMember(destination => destination.oficioAnotacionNumero, source => source.MapFrom(src => src.oficioAnotacionNumero))
                .ForMember(destination => destination.oficioAnotacionFecha, source => source.MapFrom(src => src.oficioAnotacionFecha))
                .ForMember(destination => destination.oficioAnotacionArchivo, source => source.MapFrom(src => src.oficioAnotacionArchivo))
                .ForMember(destination => destination.evidenciaAnotacionFecha, source => source.MapFrom(src => src.evidenciaAnotacionFecha))
                .ForMember(destination => destination.evidenciaAnotacionArchivo, source => source.MapFrom(src => src.evidenciaAnotacionArchivo))
                .ForMember(destination => destination.estadoDerivacion, source => source.MapFrom(src => src.estadoDerivacion))
                .ForMember(destination => destination.solicitudDiasTranscurridos, source => source.MapFrom(src => src.solicitudDiasTranscurridos))
                .ForMember(destination => destination.constanciaAnotacionArchivo, source => source.MapFrom(src => src.constanciaAnotacionArchivo))
                .ForMember(destination => destination.constanciaAnotacionFirmadaFecha, source => source.MapFrom(src => src.constanciaAnotacionFirmadaFecha))
                .ForMember(destination => destination.constanciaAnotacionFirmadaArchivo, source => source.MapFrom(src => src.constanciaAnotacionFirmadaArchivo))
                .ForMember(destination => destination.respuestaGoreNumero, source => source.MapFrom(src => src.respuestaGoreNumero))
                .ForMember(destination => destination.respuestaGoreFecha, source => source.MapFrom(src => src.respuestaGoreFecha))
                .ForMember(destination => destination.respuestaGoreArchivo, source => source.MapFrom(src => src.respuestaGoreArchivo))
                .ForMember(destination => destination.archivado, source => source.MapFrom(src => src.archivado))
                .ForMember(destination => destination.esDerivado, source => source.MapFrom(src => src.esDerivado))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.Circunscripcion, source => source.MapFrom(src => src.Circunscripcion));

            /* Especialista SSIAT */

            CreateMap<InformeRenacDto, EspecialistaSsiatPaginatedFilterRequest>().ReverseMap()
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeRenacDto, EspecialistaSsiatResponse>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.fecha, source => source.MapFrom(src => src.fecha))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.urlinformesustento, source => source.MapFrom(src => src.urlinformesustento))
                .ForMember(destination => destination.nombreinformesustento, source => source.MapFrom(src => src.nombreinformesustento))
                .ForMember(destination => destination.estadoDerivacion, source => source.MapFrom(src => src.estadoDerivacion))
                .ForMember(destination => destination.esDerivado, source => source.MapFrom(src => src.esDerivado))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.Circunscripcion, source => source.MapFrom(src => src.Circunscripcion));

            /* Subsecretario SSIAT */

            CreateMap<InformeRenacDto, SubsecretarioSsiatPaginatedFilterRequest>().ReverseMap()
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeRenacDto, SubsecretarioSsiatResponse>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.urlinformesustento, source => source.MapFrom(src => src.urlinformesustento))
                .ForMember(destination => destination.nombreinformesustento, source => source.MapFrom(src => src.nombreinformesustento))
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.estadoSsiat, source => source.MapFrom(src => src.estadoSsiat))
                .ForMember(destination => destination.estadoAnotacion, source => source.MapFrom(src => src.estadoAnotacion))
                .ForMember(destination => destination.estadoDerivacion, source => source.MapFrom(src => src.estadoDerivacion))
                .ForMember(destination => destination.Circunscripcion, source => source.MapFrom(src => src.Circunscripcion));

            /* Subsecretario SSATDOT */

            CreateMap<InformeRenacDto, SubsecretarioSsatdotPaginatedFilterRequest>().ReverseMap()
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeRenacDto, SubsecretarioSsatdotResponse>().ReverseMap()
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.estadoDerivacion, source => source.MapFrom(src => src.estadoDerivacion))
                .ForMember(destination => destination.Circunscripcion, source => source.MapFrom(src => src.Circunscripcion));

            CreateMap<InformeRenacDto, SubsecretarioSsatdotDerivacionInformesPaginatedFilterRequest>().ReverseMap()
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeRenacDto, SubsecretarioSsatdotDerivacionInformesResponse>().ReverseMap()
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.evaluacionFavorable, source => source.MapFrom(src => src.evaluacionFavorable))
                .ForMember(destination => destination.estadoDerivacion, source => source.MapFrom(src => src.estadoDerivacion))
                .ForMember(destination => destination.esDerivado, source => source.MapFrom(src => src.esDerivado))
                .ForMember(destination => destination.Circunscripcion, source => source.MapFrom(src => src.Circunscripcion));

            /*  Informacion SSIAT documentos */

            CreateMap<InformeRenacDto, InformacionSsiatDocumentosRequest>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac));

            CreateMap<InformacionSsiatDocumentosResponse, InformeRenacDto>().ReverseMap()
                .ForMember(destination => destination.numeroPartida, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.informeAnotacion, source => source.MapFrom(src => src.urlinformesustento))
                .ForMember(destination => destination.proyectoMemoEspSsiat, source => source.MapFrom(src => src.urlProyectoMemoEspSsiat))
                .ForMember(destination => destination.proyectoMemoSubSsiat, source => source.MapFrom(src => src.urlProyectoMemoSubSsiat))
                .ForMember(destination => destination.respuestaGore, source => source.MapFrom(src => src.urlRespuestaGore));

            /* Especialista SSATDOT */

            CreateMap<InformeRenacDto, EspecialistaSsatdotPaginatedFilterRequest>().ReverseMap()
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeRenacDto, EspecialistaSsatdotResponse>().ReverseMap()
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.estadoDerivacion, source => source.MapFrom(src => src.estadoDerivacion))
                .ForMember(destination => destination.Circunscripcion, source => source.MapFrom(src => src.Circunscripcion));

            CreateMap<InformeRenacDto, UpdateEvaluacionFavorableRequest>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.evaluacionFavorable, source => source.MapFrom(src => src.evaluacionFavorable));

            CreateMap<InformeRenacDto, UpdateInformesOpinionFavorableRequest>().ReverseMap()
                .ForMember(destination => destination.informeFavorableArchivo, source => source.MapFrom(src => src.informeFavorableArchivo))
                .ForMember(destination => destination.informeFavorableNumero, source => source.MapFrom(src => src.informeFavorableNumero))
                .ForMember(destination => destination.informeFavorableFecha, source => source.MapFrom(src => src.informeFavorableFecha))
                .ForMember(destination => destination.listaInformesRenac, source => source.MapFrom(src => src.listaInformesRenac))
                .ForMember(destination => destination.informeFavorableArchivoBase64, source => source.MapFrom(src => src.informeFavorableArchivoBase64));

            CreateMap<InformeRenacDto, VerificarInformeEvaluacionFavorableRequest>().ReverseMap()
                .ForMember(destination => destination.listaInformesRenac, source => source.MapFrom(src => src.listaInformesRenac));

            /* Responsable de archivo  - Solicitud de informacion */

            CreateMap<InformeRenacDto, ResponsableArchivoSolicitudInformacionRequest>().ReverseMap()
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeRenacDto, ResponsableArchivoSolicitudInformacionResponse>().ReverseMap()
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.evaluacionFavorable, source => source.MapFrom(src => src.evaluacionFavorable))
                .ForMember(destination => destination.estadoDerivacion, source => source.MapFrom(src => src.estadoDerivacion))
                .ForMember(destination => destination.esDerivado, source => source.MapFrom(src => src.esDerivado))
                .ForMember(destination => destination.Circunscripcion, source => source.MapFrom(src => src.Circunscripcion));

            CreateMap<InformeRenacDto, UpdateSolicitudInformacionRequest>().ReverseMap()
                .ForMember(destination => destination.oficioSolicitudNumero, source => source.MapFrom(src => src.oficioSolicitudNumero))
                .ForMember(destination => destination.oficioSolicitudFecha, source => source.MapFrom(src => src.oficioSolicitudFecha))
                .ForMember(destination => destination.evidenciaSolicitudFecha, source => source.MapFrom(src => src.evidenciaSolicitudFecha))
                .ForMember(destination => destination.listaInformesRenac, source => source.MapFrom(src => src.listaInformesRenac))
                .ForMember(destination => destination.oficioSolicitudArchivo, source => source.MapFrom(src => src.oficioSolicitudArchivo))
                .ForMember(destination => destination.evidenciaSolicitudArchivo, source => source.MapFrom(src => src.evidenciaSolicitudArchivo))
                .ForMember(destination => destination.oficioSolicitudArchivoBase64, source => source.MapFrom(src => src.oficioSolicitudArchivoBase64))
                .ForMember(destination => destination.evidenciaSolicitudArchivoBase64, source => source.MapFrom(src => src.evidenciaSolicitudArchivoBase64));

            /*  Especialista SSIAT - registro de formatos / Respuesta GORE  */

            CreateMap<InformeRenacDto, EspecialistaSsiatRegistroFormatosRequest>().ReverseMap()
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeRenacDto, EspecialistaSsiatRegistroFormatosResponse>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.evaluacionFavorable, source => source.MapFrom(src => src.evaluacionFavorable))
                .ForMember(destination => destination.constanciaAnotacionArchivo, source => source.MapFrom(src => src.constanciaAnotacionArchivo))
                .ForMember(destination => destination.respuestaGoreArchivo, source => source.MapFrom(src => src.respuestaGoreArchivo))
                .ForMember(destination => destination.solicitudGore, source => source.MapFrom(src => src.solicitudGore))
                .ForMember(destination => destination.estadoDerivacion, source => source.MapFrom(src => src.estadoDerivacion))
                .ForMember(destination => destination.esDerivado, source => source.MapFrom(src => src.esDerivado))
                .ForMember(destination => destination.solicitudDiasTranscurridos, source => source.MapFrom(src => src.solicitudDiasTranscurridos))
                .ForMember(destination => destination.Circunscripcion, source => source.MapFrom(src => src.Circunscripcion));

            /* Registro de Constancia Anotacion*/

            CreateMap<InformeRenacDto, UpdateConstanciaAnotacionRequest>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.constanciaAnotacionArchivo, source => source.MapFrom(src => src.constanciaAnotacionArchivo))
                .ForMember(destination => destination.constanciaAnotacionBase64, source => source.MapFrom(src => src.constanciaAnotacionBase64));

            /*   Registrar Respuesta GORE   */

            CreateMap<InformeRenacDto, UpdateRespuestaGoreRequest>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.respuestaGoreNumero, source => source.MapFrom(src => src.respuestaGoreNumero))
                .ForMember(destination => destination.respuestaGoreFecha, source => source.MapFrom(src => src.respuestaGoreFecha))
                .ForMember(destination => destination.respuestaGoreArchivo, source => source.MapFrom(src => src.respuestaGoreArchivo))
                .ForMember(destination => destination.respuestaGoreBase64, source => source.MapFrom(src => src.respuestaGoreBase64))
                .ForMember(destination => destination.listaInformesRenac, source => source.MapFrom(src => src.listaInformesRenac));

            /*  Subsecretario SSIAT - Registro de anotación  */

            CreateMap<InformeRenacDto, SubsecretarioSsiatRegistroAnotacionRequest>().ReverseMap()
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeRenacDto, SubsecretarioSsiatRegistroAnotacionResponse>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.evaluacionFavorable, source => source.MapFrom(src => src.evaluacionFavorable))
                .ForMember(destination => destination.solicitudGore, source => source.MapFrom(src => src.solicitudGore))
                .ForMember(destination => destination.constanciaAnotacionArchivo, source => source.MapFrom(src => src.constanciaAnotacionArchivo))
                .ForMember(destination => destination.constanciaAnotacionFirmadaArchivo, source => source.MapFrom(src => src.constanciaAnotacionFirmadaArchivo))
                .ForMember(destination => destination.respuestaGoreArchivo, source => source.MapFrom(src => src.respuestaGoreArchivo))
                .ForMember(destination => destination.estadoDerivacion, source => source.MapFrom(src => src.estadoDerivacion))
                .ForMember(destination => destination.esDerivado, source => source.MapFrom(src => src.esDerivado))
                .ForMember(destination => destination.Circunscripcion, source => source.MapFrom(src => src.Circunscripcion));

            /*  Responsable de archivo - Registro anotacion  */

            CreateMap<InformeRenacDto, ResponsableArchivoRegistroAnotacionRequest>().ReverseMap()
               .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
               .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
               .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeRenacDto, ResponsableArchivoRegistroAnotacionResponse>().ReverseMap()
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idCircunscripcion, source => source.MapFrom(src => src.idCircunscripcion))
                .ForMember(destination => destination.idEstadoDerivacion, source => source.MapFrom(src => src.idEstadoDerivacion))
                .ForMember(destination => destination.constanciaAnotacionArchivo, source => source.MapFrom(src => src.constanciaAnotacionArchivo))
                .ForMember(destination => destination.constanciaAnotacionFirmadaArchivo, source => source.MapFrom(src => src.constanciaAnotacionFirmadaArchivo))
                .ForMember(destination => destination.respuestaGoreArchivo, source => source.MapFrom(src => src.respuestaGoreArchivo))
                .ForMember(destination => destination.procesoAnotacionCerrado, source => source.MapFrom(src => src.procesoAnotacionCerrado))
                .ForMember(destination => destination.solicitudGore, source => source.MapFrom(src => src.solicitudGore))
                .ForMember(destination => destination.informeFavorableArchivo, source => source.MapFrom(src => src.informefavorablearchivo))
                .ForMember(destination => destination.numero, source => source.MapFrom(src => src.numero))
                .ForMember(destination => destination.evaluacionFavorable, source => source.MapFrom(src => src.evaluacionFavorable))
                .ForMember(destination => destination.estadoDerivacion, source => source.MapFrom(src => src.estadoDerivacion))
                .ForMember(destination => destination.esDerivado, source => source.MapFrom(src => src.esDerivado))
                .ForMember(destination => destination.Circunscripcion, source => source.MapFrom(src => src.Circunscripcion));             

            CreateMap<InformeRenacDto, UpdateRegistroAnotacionRequest>().ReverseMap()
                .ForMember(destination => destination.oficioAnotacionNumero, source => source.MapFrom(src => src.oficioAnotacionNumero))
                .ForMember(destination => destination.oficioAnotacionFecha, source => source.MapFrom(src => src.oficioAnotacionFecha))
                .ForMember(destination => destination.oficioAnotacionArchivo, source => source.MapFrom(src => src.oficioAnotacionArchivo))
                .ForMember(destination => destination.evidenciaAnotacionFecha, source => source.MapFrom(src => src.evidenciaAnotacionFecha))
                .ForMember(destination => destination.evidenciaAnotacionArchivo, source => source.MapFrom(src => src.evidenciaAnotacionArchivo))
                .ForMember(destination => destination.oficioAnotacionArchivoBase64, source => source.MapFrom(src => src.oficioAnotacionArchivoBase64))
                .ForMember(destination => destination.evidenciaAnotacionArchivoBase64, source => source.MapFrom(src => src.evidenciaAnotacionArchivoBase64))
                .ForMember(destination => destination.listaInformesRenac, source => source.MapFrom(src => src.listaInformesRenac));

            /* Registro de Constancia Anotacion Firmada */

            CreateMap<InformeRenacDto, UpdateConstanciaAnotacionFirmadaRequest>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.constanciaAnotacionFirmadaFecha, source => source.MapFrom(src => src.constanciaAnotacionFirmadaFecha))
                .ForMember(destination => destination.constanciaAnotacionFirmadaArchivo, source => source.MapFrom(src => src.constanciaAnotacionFirmadaArchivo))
                .ForMember(destination => destination.constanciaAnotacionFirmadaArchivo64, source => source.MapFrom(src => src.constanciaAnotacionFirmadaArchivo64));

            /*  Cerrar proceso de anotacion  */
            CreateMap<InformeRenacDto, CerrarProcesoAnotacionRequest>().ReverseMap()
                .ForMember(destination => destination.listaInformesRenac, source => source.MapFrom(src => src.listaInformesRenac));

            #endregion

            #region AsientoCircunscripcion

            CreateMap<AsientoCircunscripcion, AsientoCircunscripcionDto>().ReverseMap()
                .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idTipoAsiento, source => source.MapFrom(src => src.idTipoAsiento))
                .ForMember(destination => destination.idDispositivo, source => source.MapFrom(src => src.idDispositivo))
                .ForMember(destination => destination.numeroAsiento, source => source.MapFrom(src => src.numeroAsiento))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.nombreCircunscripcion, source => source.MapFrom(src => src.nombreCircunscripcion))
                .ForMember(destination => destination.nombreCapital, source => source.MapFrom(src => src.nombreCapital))
                .ForMember(destination => destination.nombreProvincia, source => source.MapFrom(src => src.nombreProvincia))
                .ForMember(destination => destination.nombreDepartamento, source => source.MapFrom(src => src.nombreDepartamento))
                .ForMember(destination => destination.informacionComplementaria, source => source.MapFrom(src => src.informacionComplementaria))
                .ForMember(destination => destination.fechaAnotacion, source => source.MapFrom(src => src.fechaAnotacion))
                .ForMember(destination => destination.detalle_modificacion, source => source.MapFrom(src => src.detalle_modificacion))
                .ForMember(destination => destination.detallesModificacion, source => source.MapFrom(src => src.detallesModificacion))
                .ForMember(destination => destination.circunscripcionOrigenes, source => source.MapFrom(src => src.circunscripcionOrigenes))
                .ForMember(destination => destination.circunscripcionDestinos, source => source.MapFrom(src => src.circunscripcionDestinos))
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
                .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
                .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
                .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod))
                .ForMember(destination => destination.InformeRenac, source => source.MapFrom(src => src.InformeRenac))
                .ForMember(destination => destination.TipoAsiento, source => source.MapFrom(src => src.TipoAsiento))
                .ForMember(destination => destination.Norma, source => source.MapFrom(src => src.Norma));

            CreateMap<AsientoCircunscripcionDto, AsientoCircunscripcionInsertRequest>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idTipoAsiento, source => source.MapFrom(src => src.idTipoAsiento))
                .ForMember(destination => destination.idDispositivo, source => source.MapFrom(src => src.idDispositivo))
                .ForMember(destination => destination.numeroAsiento, source => source.MapFrom(src => src.numeroAsiento))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.nombreCircunscripcion, source => source.MapFrom(src => src.nombreCircunscripcion))
                .ForMember(destination => destination.nombreCapital, source => source.MapFrom(src => src.nombreCapital))
                .ForMember(destination => destination.nombreProvincia, source => source.MapFrom(src => src.nombreProvincia))
                .ForMember(destination => destination.nombreDepartamento, source => source.MapFrom(src => src.nombreDepartamento))
                .ForMember(destination => destination.informacionComplementaria, source => source.MapFrom(src => src.informacionComplementaria))
                .ForMember(destination => destination.fechaAnotacion, source => source.MapFrom(src => src.fechaAnotacion))
                .ForMember(destination => destination.detallesModificacion, source => source.MapFrom(src => src.detallesModificacion))
                .ForMember(destination => destination.circunscripcionOrigenes, source => source.MapFrom(src => src.circunscripcionOrigenes))
                .ForMember(destination => destination.circunscripcionDestinos, source => source.MapFrom(src => src.circunscripcionDestinos))
                .ForMember(destination => destination.codTipoAsiento, source => source.MapFrom(src => src.codTipoAsiento))
                .ForMember(destination => destination.tipoCircunscripcion, source => source.MapFrom(src => src.tipoCircunscripcion));

            CreateMap<AsientoCircunscripcionDto, AsientoCircunscripcionUpdateRequest>().ReverseMap()
                .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idTipoAsiento, source => source.MapFrom(src => src.idTipoAsiento))
                .ForMember(destination => destination.idDispositivo, source => source.MapFrom(src => src.idDispositivo))
                .ForMember(destination => destination.numeroAsiento, source => source.MapFrom(src => src.numeroAsiento))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.nombreCircunscripcion, source => source.MapFrom(src => src.nombreCircunscripcion))
                .ForMember(destination => destination.nombreCapital, source => source.MapFrom(src => src.nombreCapital))
                .ForMember(destination => destination.nombreProvincia, source => source.MapFrom(src => src.nombreProvincia))
                .ForMember(destination => destination.nombreDepartamento, source => source.MapFrom(src => src.nombreDepartamento))
                .ForMember(destination => destination.informacionComplementaria, source => source.MapFrom(src => src.informacionComplementaria))
                .ForMember(destination => destination.fechaAnotacion, source => source.MapFrom(src => src.fechaAnotacion))
                .ForMember(destination => destination.detallesModificacion, source => source.MapFrom(src => src.detallesModificacion))
                .ForMember(destination => destination.circunscripcionOrigenes, source => source.MapFrom(src => src.circunscripcionOrigenes))
                .ForMember(destination => destination.circunscripcionDestinos, source => source.MapFrom(src => src.circunscripcionDestinos))
                .ForMember(destination => destination.codTipoAsiento, source => source.MapFrom(src => src.codTipoAsiento))
                .ForMember(destination => destination.tipoCircunscripcion, source => source.MapFrom(src => src.tipoCircunscripcion));

            CreateMap<AsientoCircunscripcionDto, AsientoCircunscripcionFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idTipoAsiento, source => source.MapFrom(src => src.idTipoAsiento))
                .ForMember(destination => destination.idDispositivo, source => source.MapFrom(src => src.idDispositivo))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<AsientoCircunscripcionDto, AsientoCircunscripcionPaginacionFiltroRequest>().ReverseMap()
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<AsientoCircunscripcionDto, AsientoCircunscripcionIdRequest>().ReverseMap()
                .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion));

            CreateMap<AsientoCircunscripcionDto, AsientoCircunscripcionResponse>().ReverseMap()
                .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idTipoAsiento, source => source.MapFrom(src => src.idTipoAsiento))
                .ForMember(destination => destination.idDispositivo, source => source.MapFrom(src => src.idDispositivo))
                .ForMember(destination => destination.numeroAsiento, source => source.MapFrom(src => src.numeroAsiento))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.nombreCircunscripcion, source => source.MapFrom(src => src.nombreCircunscripcion))
                .ForMember(destination => destination.nombreCapital, source => source.MapFrom(src => src.nombreCapital))
                .ForMember(destination => destination.nombreProvincia, source => source.MapFrom(src => src.nombreProvincia))
                .ForMember(destination => destination.nombreDepartamento, source => source.MapFrom(src => src.nombreDepartamento))
                .ForMember(destination => destination.informacionComplementaria, source => source.MapFrom(src => src.informacionComplementaria))
                .ForMember(destination => destination.fechaAnotacion, source => source.MapFrom(src => src.fechaAnotacion))
                .ForMember(destination => destination.detalle_modificacion, source => source.MapFrom(src => src.detalle_modificacion))
                .ForMember(destination => destination.detallesModificacion, source => source.MapFrom(src => src.detallesModificacion))
                .ForMember(destination => destination.InformeRenac, source => source.MapFrom(src => src.InformeRenac))
                .ForMember(destination => destination.TipoAsiento, source => source.MapFrom(src => src.TipoAsiento))
                .ForMember(destination => destination.Norma, source => source.MapFrom(src => src.Norma))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo));

            CreateMap<AsientoCircunscripcionDto, InformacionSsiatAsientosRequest>().ReverseMap()
               .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac));

            CreateMap<AsientoCircunscripcionDto, InformacionSsiatAsientosResponse>().ReverseMap()
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idDispositivo, source => source.MapFrom(src => src.idDispositivo))
                .ForMember(destination => destination.nombreCircunscripcion, source => source.MapFrom(src => src.nombreCircunscripcion))
                .ForMember(destination => destination.fechaAnotacion, source => source.MapFrom(src => src.fechaAnotacion))
                .ForMember(destination => destination.InformeRenac, source => source.MapFrom(src => src.InformeRenac))
                .ForMember(destination => destination.Norma, source => source.MapFrom(src => src.Norma));

            #endregion

            #region TipoModificacionAsiento

            CreateMap<TipoModificacionAsiento, TipoModificacionAsientoDto>().ReverseMap()
            .ForMember(destination => destination.idTipoModificacionAsiento, source => source.MapFrom(src => src.idTipoModificacionAsiento))
            .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
            .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
            .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
            .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
            .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
            .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
            .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod));

            CreateMap<TipoModificacionAsientoDto, TipoModificacionAsientoInsertRequest>().ReverseMap()
              .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion));

            CreateMap<TipoModificacionAsientoDto, TipoModificacionAsientoUpdateRequest>().ReverseMap()
              .ForMember(destination => destination.idTipoModificacionAsiento, source => source.MapFrom(src => src.idTipoModificacionAsiento))
              .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion));

            CreateMap<TipoModificacionAsientoDto, TipoModificacionAsientoFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.idTipoModificacionAsiento, source => source.MapFrom(src => src.idTipoModificacionAsiento))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<TipoModificacionAsientoDto, TipoModificacionAsientoPaginacionFiltroRequest>().ReverseMap()
               .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
               .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
               .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
               .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<TipoModificacionAsientoDto, TipoModificacionAsientoIdRequest>().ReverseMap()
              .ForMember(destination => destination.idTipoModificacionAsiento, source => source.MapFrom(src => src.idTipoModificacionAsiento));

            CreateMap<TipoModificacionAsientoDto, TipoModificacionAsientoResponse>().ReverseMap()
             .ForMember(destination => destination.idTipoModificacionAsiento, source => source.MapFrom(src => src.idTipoModificacionAsiento))
             .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
             .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
             .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo));

            #endregion

            #region AsientoModificacion

            CreateMap<AsientoModificacion, AsientoModificacionDto>().ReverseMap()
            .ForMember(destination => destination.idAsientoModificacion, source => source.MapFrom(src => src.idAsientoModificacion))
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.idTipoModificacionAsiento, source => source.MapFrom(src => src.idTipoModificacionAsiento))
            .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
            .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
            .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
            .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
            .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
            .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod));

            CreateMap<AsientoModificacionDto, AsientoModificacionInsertRequest>().ReverseMap()
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.idTipoModificacionAsiento, source => source.MapFrom(src => src.idTipoModificacionAsiento));

            CreateMap<AsientoModificacionDto, AsientoModificacionUpdateRequest>().ReverseMap()
            .ForMember(destination => destination.idAsientoModificacion, source => source.MapFrom(src => src.idAsientoModificacion))
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.idTipoModificacionAsiento, source => source.MapFrom(src => src.idTipoModificacionAsiento));

            CreateMap<AsientoModificacionDto, AsientoModificacionFiltrosRequest>().ReverseMap()
            .ForMember(destination => destination.idAsientoModificacion, source => source.MapFrom(src => src.idAsientoModificacion))
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.idTipoModificacionAsiento, source => source.MapFrom(src => src.idTipoModificacionAsiento))
            .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
            .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<AsientoModificacionDto, AsientoModificacionPaginacionFiltroRequest>().ReverseMap()
            .ForMember(destination => destination.idAsientoModificacion, source => source.MapFrom(src => src.idAsientoModificacion))
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.idTipoModificacionAsiento, source => source.MapFrom(src => src.idTipoModificacionAsiento))
            .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
            .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
            .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
            .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<AsientoModificacionDto, AsientoModificacionIdRequest>().ReverseMap()
            .ForMember(destination => destination.idAsientoModificacion, source => source.MapFrom(src => src.idAsientoModificacion));

            CreateMap<AsientoModificacionDto, AsientoModificacionResponse>().ReverseMap()
            .ForMember(destination => destination.idAsientoModificacion, source => source.MapFrom(src => src.idAsientoModificacion))
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.idTipoModificacionAsiento, source => source.MapFrom(src => src.idTipoModificacionAsiento))
            .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo));

            #endregion

            #region CircunscripcionOrigenDestino

            CreateMap<CircunscripcionOrigenDestino, CircunscripcionOrigenDestinoDto>().ReverseMap()
            .ForMember(destination => destination.idCircunscripcionOrigenDestino, source => source.MapFrom(src => src.idCircunscripcionOrigenDestino))
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.nombreCircunscripcion, source => source.MapFrom(src => src.nombreCircunscripcion))
            .ForMember(destination => destination.origenDestino, source => source.MapFrom(src => src.origenDestino))
            .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
            .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
            .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
            .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
            .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
            .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod))
            .ForMember(destination => destination.AsientoCircunscripcion, source => source.MapFrom(src => src.AsientoCircunscripcion));

            CreateMap<CircunscripcionOrigenDestinoDto, CircunscripcionOrigenDestinoInsertRequest>().ReverseMap()
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.nombreCircunscripcion, source => source.MapFrom(src => src.nombreCircunscripcion))
            .ForMember(destination => destination.origenDestino, source => source.MapFrom(src => src.origenDestino));

            CreateMap<CircunscripcionOrigenDestinoDto, CircunscripcionOrigenDestinoUpdateRequest>().ReverseMap()
            .ForMember(destination => destination.idCircunscripcionOrigenDestino, source => source.MapFrom(src => src.idCircunscripcionOrigenDestino))
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.nombreCircunscripcion, source => source.MapFrom(src => src.nombreCircunscripcion))
            .ForMember(destination => destination.origenDestino, source => source.MapFrom(src => src.origenDestino));

            CreateMap<CircunscripcionOrigenDestinoDto, CircunscripcionOrigenDestinoFiltrosRequest>().ReverseMap()
            .ForMember(destination => destination.idCircunscripcionOrigenDestino, source => source.MapFrom(src => src.idCircunscripcionOrigenDestino))
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
            .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<CircunscripcionOrigenDestinoDto, CircunscripcionOrigenDestinoPaginacionFiltroRequest>().ReverseMap()
            .ForMember(destination => destination.idCircunscripcionOrigenDestino, source => source.MapFrom(src => src.idCircunscripcionOrigenDestino))
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
            .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
            .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
            .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<CircunscripcionOrigenDestinoDto, CircunscripcionOrigenDestinoIdRequest>().ReverseMap()
            .ForMember(destination => destination.idCircunscripcionOrigenDestino, source => source.MapFrom(src => src.idCircunscripcionOrigenDestino));

            CreateMap<CircunscripcionOrigenDestinoDto, CircunscripcionOrigenDestinoResponse>().ReverseMap()
            .ForMember(destination => destination.idCircunscripcionOrigenDestino, source => source.MapFrom(src => src.idCircunscripcionOrigenDestino))
            .ForMember(destination => destination.idAsientoCircunscripcion, source => source.MapFrom(src => src.idAsientoCircunscripcion))
            .ForMember(destination => destination.nombreCircunscripcion, source => source.MapFrom(src => src.nombreCircunscripcion))
            .ForMember(destination => destination.origenDestino, source => source.MapFrom(src => src.origenDestino))
            .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
            .ForMember(destination => destination.AsientoCircunscripcion, source => source.MapFrom(src => src.AsientoCircunscripcion));

            #endregion

            #region Circunscripcion

            CreateMap<Circunscripcion, CircunscripcionDto>().ReverseMap()
                .ForMember(destination => destination.CodCircunscripcion, source => source.MapFrom(src => src.CodCircunscripcion))
                .ForMember(destination => destination.NombreCircunscripcion, source => source.MapFrom(src => src.NombreCircunscripcion))
                .ForMember(destination => destination.NomCircunscripcion, source => source.MapFrom(src => src.NomCircunscripcion))
                .ForMember(destination => destination.TipCircunscripcion, source => source.MapFrom(src => src.TipCircunscripcion))
                .ForMember(destination => destination.CodDepCircunscripcion, source => source.MapFrom(src => src.CodDepCircunscripcion))
                .ForMember(destination => destination.CodProvCircunscripcion, source => source.MapFrom(src => src.CodProvCircunscripcion))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
                .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
                .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
                .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod))
                .ForMember(destination => destination.TipoCircunscripcion, source => source.MapFrom(src => src.TipoCircunscripcion));

            CreateMap<CircunscripcionDto, CircunscripcionFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.CodCircunscripcion, source => source.MapFrom(src => src.CodCircunscripcion))
                .ForMember(destination => destination.TipCircunscripcion, source => source.MapFrom(src => src.TipCircunscripcion))
                .ForMember(destination => destination.NomCircunscripcion, source => source.MapFrom(src => src.NomCircunscripcion));

            CreateMap<CircunscripcionDto, CircunscripcionResponse>().ReverseMap()
                .ForMember(destination => destination.CodCircunscripcion, source => source.MapFrom(src => src.CodCircunscripcion))
                .ForMember(destination => destination.NombreCircunscripcion, source => source.MapFrom(src => src.NombreCircunscripcion))
                .ForMember(destination => destination.NomCircunscripcion, source => source.MapFrom(src => src.NomCircunscripcion))
                .ForMember(destination => destination.TipCircunscripcion, source => source.MapFrom(src => src.TipCircunscripcion))
                .ForMember(destination => destination.CodDepCircunscripcion, source => source.MapFrom(src => src.CodDepCircunscripcion))
                .ForMember(destination => destination.CodProvCircunscripcion, source => source.MapFrom(src => src.CodProvCircunscripcion))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.TipoCircunscripcion, source => source.MapFrom(src => src.TipoCircunscripcion));

            #endregion

            #region TipoCircunscripcion

            CreateMap<TipoCircunscripcion, TipoCircunscripcionDto>().ReverseMap()
                .ForMember(destination => destination.Id, source => source.MapFrom(src => src.Id))
                .ForMember(destination => destination.Descripcion, source => source.MapFrom(src => src.Descripcion))
                .ForMember(destination => destination.Abreviado, source => source.MapFrom(src => src.Abreviado))
                .ForMember(destination => destination.Grupo, source => source.MapFrom(src => src.Grupo))
                .ForMember(destination => destination.Orden, source => source.MapFrom(src => src.Orden))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
                .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
                .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
                .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod));

            CreateMap<TipoCircunscripcionDto, TipoCircunscripcionFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.Id, source => source.MapFrom(src => src.Id))
                .ForMember(destination => destination.Grupo, source => source.MapFrom(src => src.Grupo));

            CreateMap<TipoCircunscripcionDto, TipoCircunscripcionResponse>().ReverseMap()
                .ForMember(destination => destination.Id, source => source.MapFrom(src => src.Id))
                .ForMember(destination => destination.Descripcion, source => source.MapFrom(src => src.Descripcion))
                .ForMember(destination => destination.Abreviado, source => source.MapFrom(src => src.Abreviado))
                .ForMember(destination => destination.Grupo, source => source.MapFrom(src => src.Grupo))
                .ForMember(destination => destination.Orden, source => source.MapFrom(src => src.Orden))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo));

            #endregion

            #region TipoDispositivo

            CreateMap<TipoDispositivo, TipoDispositivoDto>().ReverseMap()
                .ForMember(destination => destination.Id, source => source.MapFrom(src => src.Id))
                .ForMember(destination => destination.Descripcion, source => source.MapFrom(src => src.Descripcion))
                .ForMember(destination => destination.Abreviado, source => source.MapFrom(src => src.Abreviado))
                .ForMember(destination => destination.Grupo, source => source.MapFrom(src => src.Grupo))
                .ForMember(destination => destination.Orden, source => source.MapFrom(src => src.Orden))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
                .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
                .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
                .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod));

            CreateMap<TipoDispositivoDto, TipoDispositivoFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.Id, source => source.MapFrom(src => src.Id))
                .ForMember(destination => destination.Grupo, source => source.MapFrom(src => src.Grupo));

            CreateMap<TipoDispositivoDto, TipoDispositivoResponse>().ReverseMap()
                .ForMember(destination => destination.Id, source => source.MapFrom(src => src.Id))
                .ForMember(destination => destination.Descripcion, source => source.MapFrom(src => src.Descripcion))
                .ForMember(destination => destination.Abreviado, source => source.MapFrom(src => src.Abreviado))
                .ForMember(destination => destination.Grupo, source => source.MapFrom(src => src.Grupo))
                .ForMember(destination => destination.Orden, source => source.MapFrom(src => src.Orden))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo));

            #endregion

            #region Norma

            CreateMap<Norma, NormaDto>().ReverseMap()
                .ForMember(destination => destination.CodNorma, source => source.MapFrom(src => src.CodNorma))
                .ForMember(destination => destination.Tipo, source => source.MapFrom(src => src.Tipo))
                .ForMember(destination => destination.Numero, source => source.MapFrom(src => src.Numero))
                .ForMember(destination => destination.Fecha, source => source.MapFrom(src => src.Fecha))
                .ForMember(destination => destination.Archivo, source => source.MapFrom(src => src.Archivo))
                .ForMember(destination => destination.TipoDispositivo, source => source.MapFrom(src => src.TipoDispositivo))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
                .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
                .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
                .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod));

            CreateMap<NormaDto, NormaFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.CodNorma, source => source.MapFrom(src => src.CodNorma))
                .ForMember(destination => destination.Tipo, source => source.MapFrom(src => src.Tipo))
                .ForMember(destination => destination.Numero, source => source.MapFrom(src => src.Numero))
                .ForMember(destination => destination.Fecha, source => source.MapFrom(src => src.Fecha));

            CreateMap<NormaDto, NormaResponse>().ReverseMap()
                .ForMember(destination => destination.CodNorma, source => source.MapFrom(src => src.CodNorma))
                .ForMember(destination => destination.Tipo, source => source.MapFrom(src => src.Tipo))
                .ForMember(destination => destination.Numero, source => source.MapFrom(src => src.Numero))
                .ForMember(destination => destination.Fecha, source => source.MapFrom(src => src.Fecha))
                .ForMember(destination => destination.Archivo, source => source.MapFrom(src => src.Archivo))
                .ForMember(destination => destination.TipoDispositivo, source => source.MapFrom(src => src.TipoDispositivo))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo));

            #endregion

            #region Derivacionrenac

            CreateMap<DerivacionRenac, DerivacionRenacDto>().ReverseMap()
                .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
                .ForMember(destination => destination.idDerivacionOrigen, source => source.MapFrom(src => src.idDerivacionOrigen))
                .ForMember(destination => destination.idDerivacionDestino, source => source.MapFrom(src => src.idDerivacionDestino))
                .ForMember(destination => destination.idEspecialistaSsatdot, source => source.MapFrom(src => src.idEspecialistaSsatdot))
                .ForMember(destination => destination.fechaDerivacion, source => source.MapFrom(src => src.fechaDerivacion))
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.observacion, source => source.MapFrom(src => src.observacion))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes))
                .ForMember(destination => destination.idTipoDocumento, source => source.MapFrom(src => src.idTipoDocumento))
                .ForMember(destination => destination.documentoMemoRuta, source => source.MapFrom(src => src.documentoMemoRuta))
                .ForMember(destination => destination.documentoMemoNombre, source => source.MapFrom(src => src.documentoMemoNombre))
                .ForMember(destination => destination.numeroDocumento, source => source.MapFrom(src => src.numeroDocumento))
                .ForMember(destination => destination.fechaDocumento, source => source.MapFrom(src => src.fechaDocumento))
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
                .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
                .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
                .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod));

            CreateMap<DerivacionRenacDto, DerivacionRenacInsertRequest>().ReverseMap()
                .ForMember(destination => destination.idDerivacionOrigen, source => source.MapFrom(src => src.idDerivacionOrigen))
                .ForMember(destination => destination.idDerivacionDestino, source => source.MapFrom(src => src.idDerivacionDestino))
                .ForMember(destination => destination.fechaDerivacion, source => source.MapFrom(src => src.fechaDerivacion))
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.observacion, source => source.MapFrom(src => src.observacion))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes));

            CreateMap<DerivacionRenacDto, DerivacionRenacUpdateRequest>().ReverseMap()
                .ForMember(destination => destination.idDerivacionOrigen, source => source.MapFrom(src => src.idDerivacionOrigen))
                .ForMember(destination => destination.idDerivacionDestino, source => source.MapFrom(src => src.idDerivacionDestino))
                .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
                .ForMember(destination => destination.fechaDerivacion, source => source.MapFrom(src => src.fechaDerivacion))
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.observacion, source => source.MapFrom(src => src.observacion))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes));

            CreateMap<DerivacionRenacDto, DerivacionEspecialistaSSIATRequest>().ReverseMap()
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes))
                .ForMember(destination => destination.documentoMemoRuta, source => source.MapFrom(src => src.documentoMemoRuta))
                .ForMember(destination => destination.documentoMemoNombre, source => source.MapFrom(src => src.documentoMemoNombre))
                .ForMember(destination => destination.documentoMemoBase64, source => source.MapFrom(src => src.documentoMemoBase64));

            CreateMap<DerivacionRenacDto, DerivacionSubsecretarioSSIATRequest>().ReverseMap()
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes))
                .ForMember(destination => destination.idTipoDocumento, source => source.MapFrom(src => src.idTipoDocumento))
                .ForMember(destination => destination.documentoMemoRuta, source => source.MapFrom(src => src.documentoMemoRuta))
                .ForMember(destination => destination.documentoMemoNombre, source => source.MapFrom(src => src.documentoMemoNombre))
                .ForMember(destination => destination.numeroDocumento, source => source.MapFrom(src => src.numeroDocumento))
                .ForMember(destination => destination.fechaDocumento, source => source.MapFrom(src => src.fechaDocumento))
                .ForMember(destination => destination.documentoMemoBase64, source => source.MapFrom(src => src.documentoMemoBase64));

            CreateMap<DerivacionRenacDto, DerivacionSubsecretarioSSATDOTRequest>().ReverseMap()
                .ForMember(destination => destination.idEspecialistaSsatdot, source => source.MapFrom(src => src.idEspecialistaSsatdot))
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes));

            CreateMap<DerivacionRenacDto, DerivacionEspecialistaSSATDOTRequest>().ReverseMap()
               .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
               .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
               .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
               .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes))
               .ForMember(destination => destination.documentoMemoRuta, source => source.MapFrom(src => src.documentoMemoRuta))
               .ForMember(destination => destination.documentoMemoNombre, source => source.MapFrom(src => src.documentoMemoNombre))
               .ForMember(destination => destination.documentoMemoBase64, source => source.MapFrom(src => src.documentoMemoBase64));

            CreateMap<DerivacionRenacDto, DerivacionRenacIdRequest>().ReverseMap()
                .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac));

            CreateMap<DerivacionRenacDto, DerivacionRenacFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<DerivacionRenacDto, DerivacionRenacPaginacionFiltroRequest>().ReverseMap()
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<DerivacionRenacDto, DerivacionRenacResponse>().ReverseMap()
                .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
                .ForMember(destination => destination.idDerivacionOrigen, source => source.MapFrom(src => src.idDerivacionOrigen))
                .ForMember(destination => destination.idDerivacionDestino, source => source.MapFrom(src => src.idDerivacionDestino))
                .ForMember(destination => destination.idEspecialistaSsatdot, source => source.MapFrom(src => src.idEspecialistaSsatdot))
                .ForMember(destination => destination.fechaDerivacion, source => source.MapFrom(src => src.fechaDerivacion))
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.observacion, source => source.MapFrom(src => src.observacion))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg));

            CreateMap<DerivacionRenacDto, DerivacionAjustesSubsecretarioSsiatRequest>().ReverseMap()
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.observacion, source => source.MapFrom(src => src.observacion))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes));

            CreateMap<DerivacionRenacDto, DerivacionAjustesEspecialistaSsatdotRequest>().ReverseMap()
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.observacion, source => source.MapFrom(src => src.observacion))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes));

            CreateMap<DerivacionRenacDto, DerivacionAjustesSubsecretarioSsatdotRequest>().ReverseMap()
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.observacion, source => source.MapFrom(src => src.observacion))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes));

            CreateMap<DerivacionRenacDto, DerivacionInformesSubsecretarioSsatdotRequest>().ReverseMap()
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes))
                .ForMember(destination => destination.idTipoDocumento, source => source.MapFrom(src => src.idTipoDocumento))
                .ForMember(destination => destination.documentoMemoRuta, source => source.MapFrom(src => src.documentoMemoRuta))
                .ForMember(destination => destination.documentoMemoNombre, source => source.MapFrom(src => src.documentoMemoNombre))
                .ForMember(destination => destination.fechaDocumento, source => source.MapFrom(src => src.fechaDocumento))
                .ForMember(destination => destination.numeroDocumento, source => source.MapFrom(src => src.numeroDocumento))
                .ForMember(destination => destination.documentoMemoBase64, source => source.MapFrom(src => src.documentoMemoBase64));

            CreateMap<DerivacionRenacDto, DerivacionInformesResponsableArchivoRequest>().ReverseMap()
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes));

            CreateMap<DerivacionRenacDto, DerivacionModificacionEspecialistaSsiatRequest>().ReverseMap()
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.observacion, source => source.MapFrom(src => src.observacion))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes));

            CreateMap<DerivacionRenacDto, DerivacionParaAnotacionEspecialistaSsiatRequest>().ReverseMap()
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes))
                .ForMember(destination => destination.documentoMemoRuta, source => source.MapFrom(src => src.documentoMemoRuta))
                .ForMember(destination => destination.documentoMemoNombre, source => source.MapFrom(src => src.documentoMemoNombre))
                .ForMember(destination => destination.documentoMemoBase64, source => source.MapFrom(src => src.documentoMemoBase64));

            CreateMap<DerivacionRenacDto, DerivacionParaAnotacionSubsecretarioSsiatRequest>().ReverseMap()
                .ForMember(destination => destination.usuarioOrigen, source => source.MapFrom(src => src.usuarioOrigen))
                .ForMember(destination => destination.usuarioDestino, source => source.MapFrom(src => src.usuarioDestino))
                .ForMember(destination => destination.esRetorno, source => source.MapFrom(src => src.esRetorno))
                .ForMember(destination => destination.derivacioninformes, source => source.MapFrom(src => src.derivacioninformes))
                .ForMember(destination => destination.documentoMemoRuta, source => source.MapFrom(src => src.documentoMemoRuta))
                .ForMember(destination => destination.documentoMemoNombre, source => source.MapFrom(src => src.documentoMemoNombre))
                .ForMember(destination => destination.fechaDocumento, source => source.MapFrom(src => src.fechaDocumento))
                .ForMember(destination => destination.numeroDocumento, source => source.MapFrom(src => src.numeroDocumento))
                .ForMember(destination => destination.documentoMemoBase64, source => source.MapFrom(src => src.documentoMemoBase64));

            #endregion

            #region InformeDerivacion

            CreateMap<InformeDerivacion, InformeDerivacionDto>().ReverseMap()
              .ForMember(destination => destination.idInformeDerivacion, source => source.MapFrom(src => src.idInformeDerivacion))
              .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
              .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
              .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
              .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
              .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
              .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
              .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
              .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod))
              .ForMember(destination => destination.InformeRenac, source => source.MapFrom(src => src.InformeRenac))
              .ForMember(destination => destination.DerivacionRenac, source => source.MapFrom(src => src.DerivacionRenac));

            CreateMap<InformeDerivacionDto, InformeDerivacionInsertRequest>().ReverseMap()
              .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
              .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac));

            CreateMap<InformeDerivacionDto, InformeDerivacionUpdateRequest>().ReverseMap()
              .ForMember(destination => destination.idInformeDerivacion, source => source.MapFrom(src => src.idInformeDerivacion))
              .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
              .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac));

            CreateMap<InformeDerivacionDto, InformeDerivacionIdRequest>().ReverseMap()
              .ForMember(destination => destination.idInformeDerivacion, source => source.MapFrom(src => src.idInformeDerivacion));

            CreateMap<InformeDerivacionDto, InformeDerivacionFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.idInformeDerivacion, source => source.MapFrom(src => src.idInformeDerivacion))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeDerivacionDto, InformeDerivacionPaginacionFiltroRequest>().ReverseMap()
               .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
               .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
               .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
               .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<InformeDerivacionDto, InformeDerivacionResponse>().ReverseMap()
                .ForMember(destination => destination.idInformeDerivacion, source => source.MapFrom(src => src.idInformeDerivacion))
                .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
                .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.InformeRenac, source => source.MapFrom(src => src.InformeRenac))
                .ForMember(destination => destination.DerivacionRenac, source => source.MapFrom(src => src.DerivacionRenac));

            #endregion

            #region TipoDocumentoRenac

            CreateMap<TipoDocumentoRenac, TipoDocumentoRenacDto>().ReverseMap()
                .ForMember(destination => destination.idTipoDocumentoRenac, source => source.MapFrom(src => src.idTipoDocumentoRenac))
                .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
                .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
                .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
                .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod));

            CreateMap<TipoDocumentoRenacDto, TipoDocumentoRenacInsertRequest>().ReverseMap()
                .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion));

            CreateMap<TipoDocumentoRenacDto, TipoDocumentoRenacUpdateRequest>().ReverseMap()
                .ForMember(destination => destination.idTipoDocumentoRenac, source => source.MapFrom(src => src.idTipoDocumentoRenac))
                .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion));

            CreateMap<TipoDocumentoRenacDto, TipoDocumentoRenacIdRequest>().ReverseMap()
                .ForMember(destination => destination.idTipoDocumentoRenac, source => source.MapFrom(src => src.idTipoDocumentoRenac));

            CreateMap<TipoDocumentoRenacDto, TipoDocumentoRenacFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.idTipoDocumentoRenac, source => source.MapFrom(src => src.idTipoDocumentoRenac))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<TipoDocumentoRenacDto, TipoDocumentoRenacPaginacionFiltroRequest>().ReverseMap()
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<TipoDocumentoRenacDto, TipoDocumentoRenacResponse>().ReverseMap()
                .ForMember(destination => destination.idTipoDocumentoRenac, source => source.MapFrom(src => src.idTipoDocumentoRenac))
                .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo));

            #endregion

            #region DocumentoDerivacion

            CreateMap<DocumentoDerivacion, DocumentoDerivacionDto>().ReverseMap()
                .ForMember(destination => destination.idDocumentoDerivacion, source => source.MapFrom(src => src.idDocumentoDerivacion))
                .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
                .ForMember(destination => destination.idTipoDocumentoRenac, source => source.MapFrom(src => src.idTipoDocumentoRenac))
                .ForMember(destination => destination.rutaDocumento, source => source.MapFrom(src => src.rutaDocumento))
                .ForMember(destination => destination.nombreDocumento, source => source.MapFrom(src => src.nombreDocumento))
                .ForMember(destination => destination.fechaDocumento, source => source.MapFrom(src => src.fechaDocumento))
                .ForMember(destination => destination.numeroDocumento, source => source.MapFrom(src => src.numeroDocumento))
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
                .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
                .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
                .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod))
                .ForMember(destination => destination.DerivacionRenac, source => source.MapFrom(src => src.DerivacionRenac))
                .ForMember(destination => destination.TipoDocumentoRenac, source => source.MapFrom(src => src.TipoDocumentoRenac));

            CreateMap<DocumentoDerivacionDto, DocumentoDerivacionInsertRequest>().ReverseMap()
                .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
                .ForMember(destination => destination.idTipoDocumentoRenac, source => source.MapFrom(src => src.idTipoDocumentoRenac))
                .ForMember(destination => destination.rutaDocumento, source => source.MapFrom(src => src.rutaDocumento))
                .ForMember(destination => destination.nombreDocumento, source => source.MapFrom(src => src.nombreDocumento));

            CreateMap<DocumentoDerivacionDto, DocumentoDerivacionUpdateRequest>().ReverseMap()
                .ForMember(destination => destination.idDocumentoDerivacion, source => source.MapFrom(src => src.idDocumentoDerivacion))
                 .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
                .ForMember(destination => destination.idTipoDocumentoRenac, source => source.MapFrom(src => src.idTipoDocumentoRenac))
                .ForMember(destination => destination.rutaDocumento, source => source.MapFrom(src => src.rutaDocumento))
                .ForMember(destination => destination.nombreDocumento, source => source.MapFrom(src => src.nombreDocumento));

            CreateMap<DocumentoDerivacionDto, DocumentoDerivacionIdRequest>().ReverseMap()
              .ForMember(destination => destination.idDocumentoDerivacion, source => source.MapFrom(src => src.idDocumentoDerivacion));

            CreateMap<DocumentoDerivacionDto, DocumentoDerivacionFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.idDocumentoDerivacion, source => source.MapFrom(src => src.idDocumentoDerivacion))
                .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<DocumentoDerivacionDto, DocumentoDerivacionPaginacionFiltroRequest>().ReverseMap()
                .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<DocumentoDerivacionDto, DocumentoDerivacionResponse>().ReverseMap()
                .ForMember(destination => destination.idDocumentoDerivacion, source => source.MapFrom(src => src.idDocumentoDerivacion))
                .ForMember(destination => destination.idDerivacionRenac, source => source.MapFrom(src => src.idDerivacionRenac))
                .ForMember(destination => destination.idTipoDocumentoRenac, source => source.MapFrom(src => src.idTipoDocumentoRenac))
                .ForMember(destination => destination.rutaDocumento, source => source.MapFrom(src => src.rutaDocumento))
                .ForMember(destination => destination.nombreDocumento, source => source.MapFrom(src => src.nombreDocumento))
                .ForMember(destination => destination.fechaDocumento, source => source.MapFrom(src => src.fechaDocumento))
                .ForMember(destination => destination.numeroDocumento, source => source.MapFrom(src => src.numeroDocumento))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.DerivacionRenac, source => source.MapFrom(src => src.DerivacionRenac))
                .ForMember(destination => destination.TipoDocumentoRenac, source => source.MapFrom(src => src.TipoDocumentoRenac));

            #endregion

            #region ParametricasRenac

            CreateMap<ParametricasRenac, ParametricasRenacDto>().ReverseMap()
                .ForMember(destination => destination.idParametricasRenac, source => source.MapFrom(src => src.idParametricasRenac))
                .ForMember(destination => destination.idPadre, source => source.MapFrom(src => src.idPadre))
                .ForMember(destination => destination.idGrupo, source => source.MapFrom(src => src.idGrupo))
                .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.rownum, source => source.MapFrom(src => src.rownum))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.usuarioReg, source => source.MapFrom(src => src.usuarioReg))
                .ForMember(destination => destination.fechaReg, source => source.MapFrom(src => src.fechaReg))
                .ForMember(destination => destination.usuarioMod, source => source.MapFrom(src => src.usuarioMod))
                .ForMember(destination => destination.fechaMod, source => source.MapFrom(src => src.fechaMod));

            CreateMap<ParametricasRenacDto, ParametricasRenacInsertRequest>().ReverseMap()
                .ForMember(destination => destination.idPadre, source => source.MapFrom(src => src.idPadre))
                .ForMember(destination => destination.idGrupo, source => source.MapFrom(src => src.idGrupo))
                .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion));

            CreateMap<ParametricasRenacDto, ParametricasRenacUpdateRequest>().ReverseMap()
                .ForMember(destination => destination.idPadre, source => source.MapFrom(src => src.idPadre))
                .ForMember(destination => destination.idParametricasRenac, source => source.MapFrom(src => src.idParametricasRenac))
                .ForMember(destination => destination.idGrupo, source => source.MapFrom(src => src.idGrupo))
                .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion));

            CreateMap<ParametricasRenacDto, ParametricasRenacIdRequest>().ReverseMap()
                .ForMember(destination => destination.idParametricasRenac, source => source.MapFrom(src => src.idParametricasRenac));

            CreateMap<ParametricasRenacDto, ParametricasRenacFiltrosRequest>().ReverseMap()
                .ForMember(destination => destination.idParametricasRenac, source => source.MapFrom(src => src.idParametricasRenac))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<ParametricasRenacDto, ParametricasRenacPaginacionFiltroRequest>().ReverseMap()
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.PageSize, source => source.MapFrom(src => src.PageSize))
                .ForMember(destination => destination.PageNumber, source => source.MapFrom(src => src.PageNumber))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo))
                .ForMember(destination => destination.filtro, source => source.MapFrom(src => src.filtro));

            CreateMap<ParametricasRenacDto, ParametricasRenacResponse>().ReverseMap()
                .ForMember(destination => destination.idParametricasRenac, source => source.MapFrom(src => src.idParametricasRenac))
                .ForMember(destination => destination.idPadre, source => source.MapFrom(src => src.idPadre))
                .ForMember(destination => destination.idGrupo, source => source.MapFrom(src => src.idGrupo))
                .ForMember(destination => destination.codigo, source => source.MapFrom(src => src.codigo))
                .ForMember(destination => destination.descripcion, source => source.MapFrom(src => src.descripcion))
                .ForMember(destination => destination.activo, source => source.MapFrom(src => src.activo));

            #endregion

            #region ConstanciaAnotacion

            CreateMap<ConstanciaAnotacion, ConstanciaAnotacionDto>().ReverseMap()
             .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac))
             .ForMember(destination => destination.fecha_informe, source => source.MapFrom(src => src.fecha_informe))
             .ForMember(destination => destination.der_sub_ssatdot, source => source.MapFrom(src => src.der_sub_ssatdot))
             .ForMember(destination => destination.der_esp_ssatdot, source => source.MapFrom(src => src.der_esp_ssatdot))
             .ForMember(destination => destination.der_sub_ssiat, source => source.MapFrom(src => src.der_sub_ssiat))
             .ForMember(destination => destination.informe_renac_registro, source => source.MapFrom(src => src.informe_renac_registro))
             .ForMember(destination => destination.asientos_desc, source => source.MapFrom(src => src.asientos_desc))
             .ForMember(destination => destination.circ_desc, source => source.MapFrom(src => src.circ_desc))
             .ForMember(destination => destination.circ_asientos, source => source.MapFrom(src => src.circ_asientos))
             .ForMember(destination => destination.circ_entidad, source => source.MapFrom(src => src.circ_entidad))
             .ForMember(destination => destination.circ_nombre, source => source.MapFrom(src => src.circ_nombre))
             .ForMember(destination => destination.analista_nombres, source => source.MapFrom(src => src.analista_nombres))
             .ForMember(destination => destination.circ_titulo, source => source.MapFrom(src => src.circ_titulo))
             .ForMember(destination => destination.circ_subtitulo, source => source.MapFrom(src => src.circ_subtitulo))
             .ForMember(destination => destination.circ_secc, source => source.MapFrom(src => src.circ_secc))
             .ForMember(destination => destination.circ_cod, source => source.MapFrom(src => src.circ_cod));

            CreateMap<ConstanciaAnotacionDto, ConstanciaAnotacionFiltrosRequest>().ReverseMap()
             .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac));

            CreateMap<ConstanciaAnotacionDto, ConstanciaAnotacionResponse>().ReverseMap()
             .ForMember(destination => destination.fecha_informe, source => source.MapFrom(src => src.fecha_informe))
             .ForMember(destination => destination.der_sub_ssatdot, source => source.MapFrom(src => src.der_sub_ssatdot))
             .ForMember(destination => destination.der_esp_ssatdot, source => source.MapFrom(src => src.der_esp_ssatdot))
             .ForMember(destination => destination.der_sub_ssiat, source => source.MapFrom(src => src.der_sub_ssiat))
             .ForMember(destination => destination.informe_renac_registro, source => source.MapFrom(src => src.informe_renac_registro))
             .ForMember(destination => destination.asientos_desc, source => source.MapFrom(src => src.asientos_desc))
             .ForMember(destination => destination.circ_desc, source => source.MapFrom(src => src.circ_desc))
             .ForMember(destination => destination.circ_asientos, source => source.MapFrom(src => src.circ_asientos))
             .ForMember(destination => destination.circ_entidad, source => source.MapFrom(src => src.circ_entidad))
             .ForMember(destination => destination.circ_nombre, source => source.MapFrom(src => src.circ_nombre))
             .ForMember(destination => destination.analista_nombres, source => source.MapFrom(src => src.analista_nombres))
             .ForMember(destination => destination.circ_titulo, source => source.MapFrom(src => src.circ_titulo))
             .ForMember(destination => destination.circ_subtitulo, source => source.MapFrom(src => src.circ_subtitulo))
             .ForMember(destination => destination.circ_secc, source => source.MapFrom(src => src.circ_secc))
             .ForMember(destination => destination.circ_cod, source => source.MapFrom(src => src.circ_cod));

            CreateMap<ConstanciaAnotacionDto, GenerarConstanciaAnotacionRequest>().ReverseMap()
             .ForMember(destination => destination.idInformeRenac, source => source.MapFrom(src => src.idInformeRenac));

            #endregion

        }
    }
}
