using PCM.RENAC.Domain.Entities;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using Table = DocumentFormat.OpenXml.Wordprocessing.Table;

namespace PCM.RENAC.Transversal.Common.Util
{
    public class ExportDocument
    {

        public static ResponseFile ExportarFormato(ConstanciaAnotacion constanciaAnotacion)
        {
            ResponseFile retorno = new ResponseFile();

            try
            {
                string pathPlantillaConstanciaAnotacion = FileApplicationKeys.PathConstanciaAnotacionPlantilla.ToString();

                using (MemoryStream memoryStream = new MemoryStream())
                {
                    // Clonar la plantilla y cargarla en el MemoryStream
                    using (FileStream fileStream = new FileStream(pathPlantillaConstanciaAnotacion, FileMode.Open))
                    {
                        fileStream.CopyTo(memoryStream);
                    }

                    using (WordprocessingDocument doc = WordprocessingDocument.Open(memoryStream, true))
                    {
                        var body = doc.MainDocumentPart.Document.Body;

                        foreach (var text in body.Descendants<Text>())
                        {
                            if (text.Text.Contains("fecha_informe"))
                            {
                                text.Text = text.Text.Replace("fecha_informe", UtilDates.DateToDescription(constanciaAnotacion.fecha_informe));
                            }
                            if (text.Text.Contains("der_sub_ssatdot"))
                            {
                                text.Text = text.Text.Replace("der_sub_ssatdot", constanciaAnotacion.der_sub_ssatdot);
                            }
                            if (text.Text.Contains("der_esp_ssatdot"))
                            {
                                text.Text = text.Text.Replace("der_esp_ssatdot", constanciaAnotacion.der_esp_ssatdot);
                            }
                            if (text.Text.Contains("der_sub_ssiat"))
                            {
                                text.Text = text.Text.Replace("der_sub_ssiat", constanciaAnotacion.der_sub_ssiat);
                            }
                            if (text.Text.Contains("informe_renac_registro"))
                            {
                                text.Text = text.Text.Replace("informe_renac_registro", constanciaAnotacion.informe_renac_registro);
                            }
                            if (text.Text.Contains("asientos_desc"))
                            {
                                text.Text = text.Text.Replace("asientos_desc", constanciaAnotacion.asientos_desc);
                            }
                            if (text.Text.Contains("circ_desc"))
                            {
                                text.Text = text.Text.Replace("circ_desc", constanciaAnotacion.circ_desc);
                            }
                            if (text.Text.Contains("circ_asientos"))
                            {
                                text.Text = text.Text.Replace("circ_asientos", constanciaAnotacion.circ_asientos);
                            }
                            if (text.Text.Contains("circ_entidad"))
                            {
                                text.Text = text.Text.Replace("circ_entidad", constanciaAnotacion.circ_entidad);
                            }
                            if (text.Text.Contains("circ_nombre"))
                            {
                                text.Text = text.Text.Replace("circ_nombre", constanciaAnotacion.circ_nombre);
                            }
                            if (text.Text.Contains("analista_nombres"))
                            {
                                text.Text = text.Text.Replace("analista_nombres", constanciaAnotacion.analista_nombres);
                            }
                            if (text.Text.Contains("circ_titulo"))
                            {
                                text.Text = text.Text.Replace("circ_titulo", constanciaAnotacion.circ_titulo);
                            }
                            if (text.Text.Contains("circ_subtitulo"))
                            {
                                text.Text = text.Text.Replace("circ_subtitulo", constanciaAnotacion.circ_subtitulo);
                            }
                            if (text.Text.Contains("circ_secc"))
                            {
                                text.Text = text.Text.Replace("circ_secc", constanciaAnotacion.circ_secc);
                            }
                            if (text.Text.Contains("circ_cod"))
                            {
                                text.Text = text.Text.Replace("circ_cod", constanciaAnotacion.circ_cod);
                            }
                        }

                        // si hay asientos formamos las tablas
                        if (constanciaAnotacion.lista_asientos != null && constanciaAnotacion.lista_asientos.Count > 0)
                        {
                            foreach (var asiento in constanciaAnotacion.lista_asientos)
                            {
                                Table tbl = CreateTableAsientos(asiento);
                                body.Append(tbl);
                            }
                        }

                        // Guardar los cambios en el MemoryStream
                        doc.Save();
                    }

                    // Convertir el contenido del MemoryStream a una cadena Base64
                    string base64String = Convert.ToBase64String(memoryStream.ToArray());

                    string contentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";

                    string exportName = $"Export_{Guid.NewGuid()}.docx";

                    // formamos los datos de retorno
                    retorno.Error = false;
                    retorno.Message = "Descarga realizada con exito.";
                    retorno.FileName = exportName;
                    retorno.base64String = base64String;
                    retorno.contentType = contentType;

                    return retorno;
                }
            }
            catch (Exception ex)
            {
                retorno.Error = true;
                retorno.Message = "Ocurrio un error al intentar descargar el archivo.";
                retorno.MessageException = ex.Message.ToString();
                return retorno;
            }
        }

        static Table CreateTableAsientos(ConstanciaAnotacionAsientos asiento)
        {
            Table table = new Table();
            string[] asientoColumnas = { "", "", "", "", "NÚMERO DE ASIENTO:", "", "TIPO DE DISPOSITIVO:", "NÚMERO:", "FECHA DE PROMULGACIÓN:", "", "NOMBRE:", "CAPITAL:", "DEPARTAMENTO:", "PROVINCIA:", "", "" };

            // Obtener las propiedades de la clase ConstanciaAnotacionAsientos
            var properties = typeof(ConstanciaAnotacionAsientos).GetProperties();

            // Recorrer las propiedades y crear filas para cada una
            for (int i = 0; i < properties.Length; i++)
            {
                var property = properties[i];
                bool isTitle = false;
                bool isMerge = (property.Name == "asiento_titulo" || property.Name == "asiento_subtitulo" || property.Name == "asiento_datos_titulo" || property.Name == "norma_titulo" || property.Name == "circ_informacion_titulo" || property.Name == "info_complementaria_titulo" || property.Name == "circ_infocomplementaria") ? true : false;

                //crear filas vacias
                if (i == 0 || i == 2)
                {
                    var rowEmpty = createRowAsientos(string.Empty, string.Empty, true, true, false, string.Empty);
                    table.AppendChild(rowEmpty);
                }
                if (i == 1)
                    isTitle = true;

                // Excluir la propiedad "idInformeRenac"
                if (property.Name != "idInformeRenac")
                {
                    // Obtener el valor de la propiedad
                    var value = property.GetValue(asiento);

                    // Formateamos la fecha
                    if (property.Name == "norma_fecha")
                        value = UtilDates.DateStringFormat(DateTime.Parse(value.ToString()));

                    // Crear una fila usando createRow, donde asientoColumnas[i] se utiliza para obtener el título
                    var row = createRowAsientos(asientoColumnas[i], value?.ToString() ?? string.Empty, false, isMerge, isTitle, property.Name);

                    // Agregar la fila a la tabla
                    table.AppendChild(row);
                }
            }

            return table;
        }

        static TableRow createRowAsientos(string valueCell_1, string valueCell_2, bool isEmpty, bool isMerge, bool isTitle, string propertyName)
        {
            TableRow tr = new TableRow();
            StringValue halfCellWidth = "5760";
            UInt32Value borderSize = 3;

            TableCell tc1 = new TableCell();
            TableCell tc2 = new TableCell();

            if (isEmpty)
            {
                tc1 = new TableCell(new Paragraph(new Run(new Text(string.Empty))));
                tc2 = new TableCell(new Paragraph(new Run(new Text(string.Empty))));
            }
            else
            {
                RunProperties runProps = new RunProperties(
                   new RunFonts { Ascii = "Arial Narrow" },
                   new FontSize { Val = "22" }
               );

                if (isMerge && propertyName != "circ_infocomplementaria")
                    runProps.Append(new Bold());

                if (isTitle)
                {
                    tc1 = new TableCell(new Paragraph(new Run(new Text(valueCell_1))));
                    tc2 = new TableCell(new Paragraph(new Run(new RunProperties(new Bold(),
                            new RunFonts { Ascii = "Arial Narrow" },
                            new FontSize { Val = "22" }),
                            new Text(valueCell_2))
                        ));
                }
                else
                {
                    tc1 = new TableCell(
                    new TableCellProperties(
                        new TableCellWidth { Type = TableWidthUnitValues.Dxa, Width = halfCellWidth },
                        new TableCellBorders(
                            new TopBorder { Val = new EnumValue<BorderValues>(BorderValues.Single), Size = borderSize },
                            new BottomBorder { Val = new EnumValue<BorderValues>(BorderValues.Single), Size = borderSize },
                            new LeftBorder { Val = new EnumValue<BorderValues>(BorderValues.Single), Size = borderSize },
                            new RightBorder { Val = new EnumValue<BorderValues>(BorderValues.Single), Size = borderSize }
                            )
                        ),
                        new Paragraph(new Run(
                            new RunProperties(
                            new RunFonts { Ascii = "Arial Narrow" },
                            new FontSize { Val = "22" }),
                            new Text(valueCell_1 ?? string.Empty))
                        )
                    );

                    tc2 = new TableCell(
                        new TableCellProperties(
                            new TableCellWidth { Type = TableWidthUnitValues.Dxa, Width = halfCellWidth },
                            new TableCellBorders(
                                new TopBorder { Val = new EnumValue<BorderValues>(BorderValues.Single), Size = borderSize },
                                new BottomBorder { Val = new EnumValue<BorderValues>(BorderValues.Single), Size = borderSize },
                                new LeftBorder { Val = new EnumValue<BorderValues>(BorderValues.Single), Size = borderSize },
                                new RightBorder { Val = new EnumValue<BorderValues>(BorderValues.Single), Size = borderSize }
                            )
                        ),
                        new Paragraph(new Run(
                            new RunProperties(
                            runProps),
                            new Text(valueCell_2 ?? string.Empty))
                        )
                    );
                }
            }

            if (isMerge)
            {
                tr.Append(tc2, tc1);

                tc1.Append(new TableCellProperties(new HorizontalMerge { Val = MergedCellValues.Continue }));
                tc2.Append(new TableCellProperties(new HorizontalMerge { Val = MergedCellValues.Restart }));
            }
            else
            {
                tr.Append(tc1, tc2);
            }

            return tr;
        }

    }
}
