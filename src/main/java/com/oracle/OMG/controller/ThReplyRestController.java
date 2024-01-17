package com.oracle.OMG.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.oracle.OMG.dto.Criteria;
import com.oracle.OMG.dto.Reply;
import com.oracle.OMG.dto.ReplyPage;
import com.oracle.OMG.service.thService.ThReplyService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/replies/*")
@RestController
@Slf4j
@RequiredArgsConstructor
public class ThReplyRestController {
	private final ThReplyService rs;
	
	@PostMapping(value = "/new")
	public ResponseEntity<String> create(@RequestBody Reply rep){

		log.info("Reply: " + rep);
		int insertCount = rs.register(rep);
		log.info("Reply INSERT COUNT: " + insertCount);
		return insertCount == 1  
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 에러코드 @GetMapping(value = "/pages/{brd_id}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE}) 
	// 정상코드 @GetMapping(value = "/pages/{brd_id}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	@GetMapping(value = "/pages/{brd_id}/{page}")
	public ResponseEntity<ReplyPage> getList(@PathVariable("brd_id") int brd_id, @PathVariable("page") int page){
		log.info("getList");
		Criteria cri = new Criteria(page,10);
		log.info("cri: "+ cri);
		return new ResponseEntity<>(rs.getListPage(cri, brd_id), HttpStatus.OK);
	}
	
	@GetMapping(value = "/{rep_id}")
	public ResponseEntity<Reply> get(@PathVariable("rep_id") int rep_id){
		
		log.info("get, rep_id: " + rep_id);
		return new ResponseEntity<>(rs.get(rep_id), HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/{rep_id}")
	public ResponseEntity<String> remove(@PathVariable("rep_id") int rep_id){
		
		log.info("remove: " + rep_id);
	
		return rs.remove(rep_id) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
		
	@PutMapping(value = "/{rep_id}")
	public ResponseEntity<String> modify(@RequestBody Reply rep, @PathVariable("rep_id") int rep_id){
		rep.setRep_id(rep_id);
		log.info("rep_id: " + rep_id);
		log.info("modify: " + rep);
		
		return rs.modify(rep) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
