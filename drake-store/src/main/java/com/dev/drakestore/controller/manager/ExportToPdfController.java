package com.dev.drakestore.controller.manager;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.drakestore.controller.user.BaseController;
import com.dev.drakestore.controller.user.SaleOrderExport;
import com.dev.drakestore.entities.SaleOrder;
import com.dev.drakestore.entities.SaleOrderProducts;
import com.dev.drakestore.entities.User;
import com.dev.drakestore.service.SaleOrderProductService;
import com.dev.drakestore.service.SaleOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ibm.icu.text.DecimalFormat;
import com.lowagie.text.DocumentException;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Controller
public class ExportToPdfController extends BaseController {

	@Autowired
	private SaleOrderService saleOrderService;

	@Autowired
	private SaleOrderProductService saleOrderProductService;

	// @GetMapping("/saleorder/export/{saleorder_id}")

	// hàm này dùng pdfwriter đang lỗi font
	@RequestMapping(value = { "/saleorder/export/{saleorder_id}" }, method = RequestMethod.GET) // -> action
	public void export(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("saleorder_id") int saleorder_id) throws DocumentException, IOException {
		response.setContentType("application/pdf; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		SaleOrder saleOrder = saleOrderService.getById(saleorder_id);
		List<SaleOrderProducts> list = saleOrderProductService.findBySaleOrderId(saleorder_id);
		DateFormat dateFM = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
		System.out.println(saleorder_id);

		String headerKey = "Content-Disposition";
		String headervalue = "attachment; filename=" + saleOrder.getCode() + ".pdf";
		response.setHeader(headerKey, headervalue);

		SaleOrderExport exporter = new SaleOrderExport(saleOrder, list);
		exporter.export(response);
	}

	//
//	@GetMapping(value = "/pdf/{saleorder_id}", produces = MediaType.APPLICATION_PDF_VALUE)
//	public ResponseEntity<byte[]> downloadInvoice(@PathVariable("saleorder_id") int saleorder_id)
//			throws JRException, IOException {
//
//		List<SaleOrderProducts> list = saleOrderProductService.findBySaleOrderId(saleorder_id);
//
//		JRBeanCollectionDataSource beanCollectionDataSource = new JRBeanCollectionDataSource(list, false);
//		SaleOrder saleOrder = saleOrderService.getById(saleorder_id);
//
//		String pattern = "###,###.###";
//		DecimalFormat decimalFormat = new DecimalFormat(pattern);
//		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
//
//		Map<String, Object> parameters = new HashMap<>();
//		parameters.put("total", decimalFormat.format(saleOrder.getTotal()));
//		parameters.put("date", formatter.format(saleOrder.getCreated_date()));
//		parameters.put("code", saleOrder.getCode());
//		parameters.put("customer_name", saleOrder.getCustomer_name());
//		parameters.put("customer_phone", saleOrder.getCustomer_phone());
//		parameters.put("customer_email", saleOrder.getCustomer_email());
//		parameters.put("customer_address", saleOrder.getCustomer_address());
//
//		JasperReport compileReport = JasperCompileManager.compileReport(new FileInputStream("sale_order.jrxml"));
//
//		JasperPrint jasperPrint = JasperFillManager.fillReport(compileReport, parameters, beanCollectionDataSource);
//
//		// JasperExportManager.exportReportToPdfFile(jasperPrint,
//		// System.currentTimeMillis() + ".pdf");
//
//		byte data[] = JasperExportManager.exportReportToPdf(jasperPrint);
//
//		System.err.println(data);
//
//		HttpHeaders headers = new HttpHeaders();
//		headers.add("Content-Disposition", "inline; filename=tinh.pdf");
//
//		return ResponseEntity.ok().headers(headers).contentType(MediaType.APPLICATION_PDF).body(data);
//	}

	public byte[] generatePDFReport(int saleorder_id) throws JRException, IOException {
		JasperReport jasperReport = JasperCompileManager
				.compileReport(ResourceUtils.getFile("classpath:reports/demo.jrxml").getAbsolutePath());

		List<SaleOrderProducts> list = saleOrderProductService.findBySaleOrderId(saleorder_id);
		JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(list);

		SaleOrder saleOrder = saleOrderService.getById(saleorder_id);

		String pattern = "###,###.###";
		DecimalFormat decimalFormat = new DecimalFormat(pattern);
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

		Map<String, Object> parameters = new HashMap<>();
		parameters.put("total", decimalFormat.format(saleOrder.getTotal()));
		parameters.put("created_date", formatter.format(saleOrder.getCreated_date()));
		parameters.put("code", saleOrder.getCode());
		parameters.put("customer_name", saleOrder.getCustomer_name());
		parameters.put("customer_phone", saleOrder.getCustomer_phone());
		parameters.put("customer_email", saleOrder.getCustomer_email());
		parameters.put("customer_address", saleOrder.getCustomer_address());

		User u = getUserLogined();
		parameters.put("created_by", u.getFull_name());
		parameters.put("export_date", formatter.format(new Date()));

		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, dataSource);

		return JasperExportManager.exportReportToPdf(jasperPrint);
	}

	@GetMapping(value = "/admin/pdf-report/{saleorder_id}", produces = MediaType.APPLICATION_PDF_VALUE)
	public ResponseEntity<byte[]> getPDFReport(@PathVariable("saleorder_id") int saleorder_id) {
		try {
			return new ResponseEntity<byte[]>(generatePDFReport(saleorder_id), HttpStatus.OK);
//			return new ResponseEntity<byte[]>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
