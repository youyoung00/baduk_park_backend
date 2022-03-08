<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Board extends CI_Controller {

	public function __construct()  //생성자
	{
		parent::__construct();
		$this->load->model('Board_model');  
	}

	public function index()
	{
		$this->list();
    } 
    
    // public function comment_counter()
    // {

    // }

	public function list(){

		//$search = $_GET['search'];
		$search = $this->input->get('search');
		$now_page =  $this->uri->segment(3); 
		//전체글 개수 가져오기
		$result_count = $this->Board_model->list_total($search); 
		//리스트 값 가져오기
        $result_list = $this->Board_model->list_select($now_page,$search);
        
        //코멘트 개수 가져오기 
        // $result_list = $this->Board_model->comment_counter();

		// pagenation 시작
		$this->load->library('pagination'); 
		$config['base_url'] = 'http://127.0.0.1:9111/index.php/board/list';
		$config['total_rows'] = $result_count->cnt;
		$config['per_page'] = 10; 
		$config['num_links'] = 3;
		$config['full_tag_open'] = '<p>'; 
		$config['full_tag_close'] = '</p>';
		$config['first_link'] = '처음으로';
		$config['last_link'] = '끝으로'; 
		$config['reuse_query_string'] = true;
		$this->pagination->initialize($config);
		//pagenation 끝
        
        

		$data['page_nation'] =  $this->pagination->create_links();
		$data['list'] = $result_list; 
        $data['search'] = $search;

        

        $result_len = count($data['list']);
        // var_dump($result_len);
        // var_dump($data['list']);

        // var_dump($data['list'][0]);
        
        for ($i = 0; $i < $result_len; $i++) {
            
            $data['list'][$i]['_id'] = intval($data['list'][$i]['_id']);
            $data['list'][$i]['view_count'] = intval($data['list'][$i]['view_count']);
            $data['list'][$i]['member_id'] = intval($data['list'][$i]['member_id']);
            $data['list'][$i]['comment_count'] = intval($data['list'][$i]['comment_count']);
            // $data['list'][$i]['comment_count'] = intval($data['list'][$i]['comment_count']);
        }
        // for ($i = 0; $i < $result_len; $i++) {
            
        //     $data['list'][$i]['view_count'] = (int) $data['list'][$i]['view_count'];
        // }
        // for ($i = 0; $i < $result_len; $i++) {
            
        //     $data['list'][$i]['member_id'] = (int) $data['list'][$i]['member_id'];
        // }
        // for ($i = 0; $i < $result_len; $i++) {
            
        //     $data['list'][$i]['comment_count'] = (int) $data['list'][$i]['comment_count'];
        // }

        // var_dump($data['list'][0]);

        $this->load->view('board/list',$data); 

        

        // $val = $data['list'][0]['member_id'];
        // echo gettype($val);

        // exit();
        
        $this->output->set_content_type('text/json');
        $this->output->set_output(json_encode($data));

	}

	public function view(){
		
		$id =  $this->input->get('id');

		$result = $this->Board_model->view_select($id);
		
		$data['result'] = $result;

		$this->load->view('board/view',$data);
		$this->comment_list($id);
	}

	public function input(){
		$this->load->view('board/input');
	}

	public function update(){
		$id =  $this->input->get('id');

		$result = $this->Board_model->view_select($id);
		
		$data['result'] = $result;


		$this->load->view('board/update',$data);
		
	}

	public function delete(){
		$id =  $this->input->get('id');

		$result = $this->Board_model->view_select($id);
		
		$data['result'] = $result;

		$this->load->view('board/update',$data);
		
	}

	private function comment_list($board_id)
	{ 
		$data['result'] = $this->Board_model->comment_list($board_id);
		$data['board_id'] = $board_id;
		
		$this->load->view("comment/list",$data);
	}

	// public function comment_delete($comment_id)
	// {
	// 	$id = $this->input->get('id');

	// 	$result = $this->Board_model->comment_list($comment_id);

	// 	$data['result'] = $result;

	// 	$this->load->view('board/update',$data); 
	// }

}