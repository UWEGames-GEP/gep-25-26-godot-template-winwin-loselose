using UnityEngine;

public class respawn : MonoBehaviour
{

    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.CompareTag("Player"))
        {
            //checks if the player hits the water, if so. respawn the player inside the building
            //we disable the character controller to allow for the position transfer to happen
            Debug.Log("yay");
            other.GetComponent<CharacterController>().enabled = false;
            other.gameObject.transform.position = new Vector3(0f, 18f, -1.5f);
            other.GetComponent<CharacterController>().enabled = true;
        }
    }
}
