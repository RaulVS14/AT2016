<?php namespace Halo;

/**
 * Class auth authenticates user and permits to check if the user has been logged in
 * Automatically loaded when the controller has $requires_auth property.
 */
class Auth
{

    public $logged_in = FALSE;
    public $is_admin = FALSE;

    function __construct()
    {
        if (isset($_SESSION['user_id'])) {
            $this->logged_in = TRUE;
            $user = get_first("SELECT *
                                       FROM kasutajad
                                       WHERE kasutaja_id = '{$_SESSION['user_id']}'");
            $this->load_user_data($user);

        }
    }

    /**
     * Verifies if the user is logged in and authenticates if not and POST contains username, else displays the login form
     * @return bool Returns true when the user has been logged in
     */
    function require_auth()
    {
        global $errors;

        // If user has already logged in...
        if ($this->logged_in) {
            return TRUE;
        }

        // Authenticate by POST data
        if (isset($_POST['username'])) {
            $username = $_POST['username'];
            $password = $_POST['password'];
            $user = get_first("SELECT kasutaja_id, is_admin FROM kasutajad
                                WHERE kasutaja_nimi = '$username'
                                  AND kasutaja_parool = '$password'");
            if (!empty($user['kasutaja_id'])) {
                $_SESSION['user_id'] = $user['kasutaja_id'];
                $this->load_user_data($user);
                return true;
            } else {
                $errors[] = "Vale kasutajanimi või parool";
            }
        }

        // Display the login form
        require 'templates/auth_template.php';

        // Prevent loading the requested controller (not authenticated)
        exit();
    }

    /**
     * Dynamically add all user table fields as object properties to auth object
     * @param $user
     */
    public function load_user_data($user)
    {
        foreach ($user as $user_attr => $value) {
            $this->$user_attr = $value;
        }
        $this->logged_in = TRUE;
    }
}
