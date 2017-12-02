using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovingCar : MonoBehaviour {

	public float speed = 0.5f;
	// Use this for initialization
	void Start () {
		GetComponent<Rigidbody>().velocity = new Vector3(0f, 0f, speed);
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
