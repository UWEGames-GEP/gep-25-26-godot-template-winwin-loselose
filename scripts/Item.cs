using Unity.VisualScripting;
using UnityEngine;

public class Item : MonoBehaviour
{

    [SerializeField] Inventory inventory;
    public string obj_name = "null";
    void Start()
    {
        inventory = GameObject.FindAnyObjectByType<Inventory>();
    }

    //sets the object to add and the name it was given by the SPAWNER.
    //checks if the player has entered the items range and adds itself to the inventory then hides self
    private void OnTriggerEnter(Collider other)
    {
        if (inventory != null && other.gameObject.CompareTag("Player"))
        {
            if(inventory.items.Count < inventory.inventory_slots.Count) // checks for the max amount of inventory slots
            {
                inventory.addItem(this.gameObject, obj_name);
                this.gameObject.SetActive(false);
            }

        }
    }
}
