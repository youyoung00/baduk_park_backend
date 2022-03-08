<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Form extends CI_Controller {

	public function __construct()  //생성자
	{
		parent::__construct();
		$this->load->model('Board_model');  
	}
	
	public function board_insert(){
		$title = $this->input->post('title');
		$content =  $this->input->post('content');

		$this->Board_model->board_insert($title,$content);

		header("Location: http://127.0.0.1:9111/index.php/board/list");
	}

	public function board_update(){
		$id = $this->input->post("id");
		$title = $this->input->post("title");
		$content = $this->input->post("content");

		$this->Board_model->board_update($id, $title, $content);

		header("Location: http://127.0.0.1:9111/index.php/board/view?id=".$id);
	}

	public function board_delete(){
		$id = $this->input->get("id");

		$this->Board_model->board_delete($id);

		header("Location: http://127.0.0.1:9111/index.php/board/list");
	}

	public function comment_insert() {

		// post 방식으로 게시물의 id, content 가져오기
		$board_id = $this->input->post('board_id');
		$content = $this->input->post('content');
	
		// 게시물의 id, content를 모델에 전달하여 삽입 쿼리 수행
		$this->Board_model->comment_insert($board_id, $content);
	
		// 삽입 쿼리 수행 완료하면 상세 페이지로 이동
		header("Location: http://127.0.0.1:9111/index.php/board/view?id=".$board_id);
	
	}
	public function comment_delete(){
		$board_id = $this->input->get("board_id");
		$comment_id = $this->input->get("comment_id");

		$this->Board_model->comment_delete($comment_id);

		header("Location: /index.php/board/view?id=".$board_id);
	}
}