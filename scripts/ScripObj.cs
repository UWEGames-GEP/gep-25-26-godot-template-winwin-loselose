using UnityEngine;

[CreateAssetMenu(fileName = "ScripObj", menuName = "Scriptable Objects/ScripObj")]
public class ScripObj : ScriptableObject
{
    //attempted scirptable object
    [Tooltip("3d_enviro")]
    [Range(0f, 1f)]
    [SerializeField]float weight = 1f;
    [SerializeField] Rigidbody rb;

    [Tooltip("back_end")]
    [Range(0f, 1f)]
    [SerializeField]int grist_cost = 0;

    [Tooltip("visuals ")]
    [SerializeField]GameObject prefab;

    [SerializeField]GameObject sylladex_icon;

}
