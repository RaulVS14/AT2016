<?php namespace Halo;

/**
 * Created by PhpStorm.
 * User: Maile
 * Date: 17.09.14
 * Time: 18:19
 */
class broneeringud extends Controller
{
    // public $requires_auth = true;

    function index()
    {

    }

    function view()
    {
        $q='SELECT * FROM broneering WHERE Bron_kuup>NOW()';
        $this->broneeringud=get_all($q);
    }

    function index_post()
    {
        $data = $_POST['data'];

        // insert('Broneering',$data);
    }

    function edit_post()
    {

    }

    function delete_post()
    {

    }

    function edit()
    {

    }

} 