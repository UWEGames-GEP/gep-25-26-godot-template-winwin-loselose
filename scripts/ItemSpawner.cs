using Cinemachine.Utility;
using Unity.VisualScripting;
using UnityEngine;

public class ItemSpawner : MonoBehaviour
{
    [SerializeField]GameObject prefab_to_spawn;
    float timer;
    [SerializeField] Material material_red;
    [SerializeField] Material material_orange;
    [SerializeField] Material material_green;

    void Update()
    {
        if(timer > 0)
        {
            timer -= 1.0f * Time.deltaTime;
        }
        else
        {
            //instantiate the prefab onto the spawner, set a randomizer for the colour and size for "random" items
            Instantiate(prefab_to_spawn, this.transform);
            int colour = Random.Range(0, 3);
            float size = Random.Range(0.2f, 0.6f);
            prefab_to_spawn.gameObject.transform.localScale = new Vector3(size, size, size);
            //grab the material on the item and change its colour to the set materials in the inspector
            //setting the "name" to associate the item for dropping and visuals
            switch (colour)
            {
                case 0:
                    prefab_to_spawn.gameObject.transform.GetChild(0).gameObject.GetComponent<MeshRenderer>().material = material_red;
                    prefab_to_spawn.gameObject.GetComponent<Item>().obj_name = "red_grist";
                    break;
                case 1:
                    prefab_to_spawn.gameObject.transform.GetChild(0).gameObject.GetComponent<MeshRenderer>().material = material_orange;
                    prefab_to_spawn.gameObject.GetComponent<Item>().obj_name = "orange_grist";
                    break;
                case 2:
                    prefab_to_spawn.gameObject.transform.GetChild(0).gameObject.GetComponent<MeshRenderer>().material = material_green;
                    prefab_to_spawn.gameObject.GetComponent<Item>().obj_name = "green_grist";
                    break;
            }
            //timer loop
            timer = Random.Range(4, 12);
        }
    }
}
