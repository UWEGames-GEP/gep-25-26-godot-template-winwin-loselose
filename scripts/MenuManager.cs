using UnityEngine;
using static GameManager;

public class MenuManager : MonoBehaviour
{
    [SerializeField] GameManager game_manager;
    [SerializeField] GameObject pause_menu;
    void Start()
    {
        //finds the game manager in the scene
        game_manager = GameObject.FindAnyObjectByType<GameManager>();
        pause_menu = GameObject.FindWithTag("p_menu");
    }

    void Update()
    {
        //checks if youre paused or not to show the menu
        if (game_manager.state == GameStates.PAUSED)
            pause_menu.SetActive(true);
        else
            pause_menu.SetActive(false);
    }
    public void play()
    {
        game_manager.state = GameStates.GAMEPLAY;
        game_manager.state_changed();
    }
    public void options()
    {

    }
    public void quit()
    {
        Application.Quit();
    }
}
