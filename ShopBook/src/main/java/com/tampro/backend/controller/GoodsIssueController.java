package com.tampro.backend.controller;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tampro.dto.InvoiceDTO;
import com.tampro.dto.Paging;
import com.tampro.dto.ProductInfoDTO;
import com.tampro.service.InvoiceService;
import com.tampro.service.ProductInfoService;
import com.tampro.utils.Constant;

@Controller
@RequestMapping("/manage/goods-issue")
public class GoodsIssueController {
	@Autowired
	InvoiceService invoiceService;
	@Autowired
	ProductInfoService productInfoService;
	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	@GetMapping(value = {"/list","/list/"})
	public String redirect() {
		return "redirect:/manage/goods-issue/list/1";
	}
	@RequestMapping("/list/{page}")
	public String showGoodsIssue(Model model,@PathVariable("page") int page,HttpSession session
			,@ModelAttribute("searchForm") InvoiceDTO invoiceDTO) {
		Paging paging = new Paging(10);
		paging.setPageIndex(page);
		
		invoiceDTO.setType(Constant.GOODS_ISSUE);
		List<InvoiceDTO> list = invoiceService.getAll(invoiceDTO, paging);
		model.addAttribute("list", list);
		model.addAttribute("pageInfo", paging);
		if(session.getAttribute(Constant.MSG_SUCCESS) != null) {
			model.addAttribute(Constant.MSG_SUCCESS, session.getAttribute(Constant.MSG_SUCCESS));
			session.removeAttribute(Constant.MSG_SUCCESS);
		}
		if(session.getAttribute(Constant.MSG_ERROR) != null) {
			model.addAttribute(Constant.MSG_ERROR, session.getAttribute(Constant.MSG_ERROR));
			session.removeAttribute(Constant.MSG_ERROR);
		}
		return "manage/issue-list";
	}
	@GetMapping("/add")
	public String addInvoice(Model model) {
		model.addAttribute("title", "Add");
		model.addAttribute("submitForm", new InvoiceDTO());
		initSelect(model);
		return "manage/issue-action";
	}
	@PostMapping("/save")
	public String saveInvoice(Model model,@ModelAttribute("submitForm") @Validated InvoiceDTO invoiceDTO , BindingResult result,HttpSession session) {
		if(result.hasErrors()) {
			if(invoiceDTO.getId() != 0) {
				model.addAttribute("title", "Edit");
				initSelect(model);
			}else {
				model.addAttribute("title", "Add");
				initSelect(model);	
			}
			return "manage/issue-action";
		}
		if(invoiceDTO.getId() != 0) {
			try {
				invoiceService.update(invoiceDTO);
				session.setAttribute(Constant.MSG_SUCCESS,"Cập nhật thành công");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				session.setAttribute(Constant.MSG_SUCCESS,"Cập nhật thất bại");
			}
		}else {
			try {
				invoiceDTO.setType(Constant.GOODS_ISSUE);
				invoiceService.add(invoiceDTO);
				session.setAttribute(Constant.MSG_SUCCESS,"Thêm thành công");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				session.setAttribute(Constant.MSG_SUCCESS,"Thêm thất bại");
			}
		}
		return "redirect:/manage/goods-issue/list/1";
	}
	@GetMapping("/edit/{id}")
	public String editInvoice(Model model,@PathVariable("id") int id) {
		InvoiceDTO invoiceDTO = invoiceService.findById(id);
		model.addAttribute("title", "Edit");
		model.addAttribute("submitForm", invoiceDTO);
		initSelect(model);
		return "manage/issue-action";
	}
	@GetMapping("/view/{id}")
	public String viewInvoice(Model model,@PathVariable("id") int id) {
		InvoiceDTO invoiceDTO = invoiceService.findById(id);
		model.addAttribute("title", "View");
		model.addAttribute("submitForm", invoiceDTO);
		return "manage/issue-action";
	}
	public void initSelect(Model model) {
		List<ProductInfoDTO> list = productInfoService.getAll(null, null);
		Collections.sort(list,new Comparator<ProductInfoDTO>() {

			@Override
			public int compare(ProductInfoDTO o1, ProductInfoDTO o2) {
				// TODO Auto-generated method stub
				return o1.getName().compareTo(o2.getName());
			}
		});
		model.addAttribute("listProduct", list);
	}
		
}