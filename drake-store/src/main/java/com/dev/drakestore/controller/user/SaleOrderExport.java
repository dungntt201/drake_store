package com.dev.drakestore.controller.user;

import java.awt.Color;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.entities.SaleOrder;
import com.dev.drakestore.entities.SaleOrderProducts;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class SaleOrderExport {

	private SaleOrder saleOrder;

	private List<SaleOrderProducts> saleOrderProducts;

	public SaleOrderExport(SaleOrder saleOrder, List<SaleOrderProducts> saleOrderProducts) {
		this.saleOrder = saleOrder;
		this.saleOrderProducts = saleOrderProducts;
	}

	private void writeTableHeader(PdfPTable table) {
		PdfPCell cell = new PdfPCell();
		cell.setPadding(5);
		Font font = FontFactory.getFont(FontFactory.HELVETICA);

		cell.setPhrase(new Phrase("Tên SP", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("Size", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("SL", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("Đơn giá", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("Thành tiền", font));
		table.addCell(cell);

	}

	private void writeTableData(PdfPTable table) {
		for (SaleOrderProducts s : saleOrderProducts) {
			table.addCell(s.getProduct_name());
			table.addCell(s.getSize());
			table.addCell(String.valueOf(s.getQuantity()));
			table.addCell(String.valueOf(s.getPrice_at_buy()));
			table.addCell(String.valueOf(s.getPrice_at_buy().multiply(new BigDecimal(s.getQuantity()))));
		}
	}

	public void export(HttpServletResponse response) throws DocumentException, IOException {
		Document document = new Document(PageSize.A4);
		PdfWriter.getInstance(document, response.getOutputStream());

		document.open();
		Font font = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
		font.setSize(18);
		font.setColor(Color.BLUE);

//		SaleOrder saleOrder1 = saleOrder;

		Paragraph p = new Paragraph("Drake Store", font);
		p.setAlignment(Paragraph.ALIGN_CENTER);

		document.add(p);
		Paragraph p1 = new Paragraph("Địa chỉ : Tân Lập - Đan Phượng - Hà Nội", font);
		p1.setAlignment(Paragraph.ALIGN_CENTER);

		document.add(p1);

		Paragraph p2 = new Paragraph("Hóa Đơn Bán Lẻ", font);
		p2.setAlignment(Paragraph.ALIGN_CENTER);

		document.add(p2);

		DateFormat dateFM = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Paragraph p3 = new Paragraph("Ngày: " + dateFM.format(saleOrder.getCreated_date()), font);
		p3.setAlignment(Paragraph.ALIGN_LEFT);

		document.add(p3);

		Paragraph p4 = new Paragraph("Số HĐ: " + saleOrder.getCode(), font);
		p4.setAlignment(Paragraph.ALIGN_LEFT);

		document.add(p4);

		Paragraph p5 = new Paragraph("Tên khách hàng: " + saleOrder.getCustomer_name(), font);
		p5.setAlignment(Paragraph.ALIGN_LEFT);

		document.add(p5);

		Paragraph p6 = new Paragraph("SĐT: " + saleOrder.getCustomer_phone(), font);
		p6.setAlignment(Paragraph.ALIGN_LEFT);

		document.add(p6);

		Paragraph p7 = new Paragraph("Email: " + saleOrder.getCustomer_email(), font);
		p7.setAlignment(Paragraph.ALIGN_LEFT);

		document.add(p7);

		Paragraph p8 = new Paragraph("Địa chỉ: " + saleOrder.getCustomer_address(), font);
		p8.setAlignment(Paragraph.ALIGN_LEFT);

		document.add(p8);

		PdfPTable table = new PdfPTable(5);
		table.setWidthPercentage(100f);
		table.setWidths(new float[] { 4.5f, 1.5f, 1.5f, 3.0f, 3.0f });
		table.setSpacingBefore(10);

		writeTableHeader(table);
		writeTableData(table);

		document.add(table);

		Paragraph p9 = new Paragraph("Tổng tiền: " + String.valueOf(saleOrder.getTotal()), font);
		p9.setAlignment(Paragraph.ALIGN_RIGHT);

		document.add(p9);

		document.close();

	}
}
