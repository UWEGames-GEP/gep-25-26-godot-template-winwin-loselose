using UnityEngine;

public class RemoveItemButton : MonoBehaviour
{
    //this script grabs your inventory, removes specifically the object selected that aligns with the index set to the object
    Inventory inventory;
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        inventory = GameObject.FindAnyObjectByType<Inventory>();
    }

    public void onBtnPress()
    {
        inventory.removeSelectedItem(inventory.slots_children.IndexOf(this.gameObject));
    }
}
