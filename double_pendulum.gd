extends Node3D
# Physical constants
const G = 9.81
const DAMPING = 0.999

# Pendulum properties
var length1 = 2.0
var length2 = 2.0
var mass1 = 1.0
var mass2 = 1.0

# State variables
var theta1 = PI/4
var theta2 = PI/4
var omega1 = 0.0
var omega2 = 0.0
var alpha1 = 0.0
var alpha2 = 0.0
var dt = 0.016

# Node references
@onready var pendulum1: Node3D = $Anchor/Pendulum1
@onready var mass1_node: Node3D = $Anchor/Pendulum1/Mass1
@onready var mass2_node: Node3D = $Anchor/Pendulum1/RigidBody3D/Mass2
@onready var rod1: Node3D = $Anchor/Pendulum1/Rod1
@onready var rod2: Node3D = $Anchor/Pendulum1/RigidBody3D/Rod2
@onready var rigid_body: Node3D = $Anchor/Pendulum1/RigidBody3D

func _ready():
	# Initial setup
	setup_pendulum()

func setup_pendulum():
	# Set up masses
	mass1_node.position = Vector3(0, -length1, 0)
	mass2_node.position = Vector3(0, -length2, 0)
	
	# Set up Rod1
	rod1.scale = Vector3(0.2, length1, 0.2)
	rod1.position = Vector3(0, -length1/2, 0)
	rod1.rotation_degrees = Vector3(0, 0, 0)
	
	# Set up Rod2
	rod2.scale = Vector3(0.2, length2, 0.2)
	rod2.position = Vector3(0, -length2/2, 0)
	rod2.rotation_degrees = Vector3(0, 0, 0)

func _physics_process(_delta):
	# Physics calculations
	var num1 = -G * (2.0 * mass1 + mass2) * sin(theta1)
	var num2 = -mass2 * G * sin(theta1 - 2.0 * theta2)
	var num3 = -2.0 * sin(theta1 - theta2) * mass2
	var num4 = omega2 * omega2 * length2 + omega1 * omega1 * length1 * cos(theta1 - theta2)
	var den = length1 * (2.0 * mass1 + mass2 - mass2 * cos(2.0 * theta1 - 2.0 * theta2))
	alpha1 = (num1 + num2 + num3 * num4) / den
	
	num1 = 2.0 * sin(theta1 - theta2)
	num2 = omega1 * omega1 * length1 * (mass1 + mass2)
	num3 = G * (mass1 + mass2) * cos(theta1)
	num4 = omega2 * omega2 * length2 * mass2 * cos(theta1 - theta2)
	den = length2 * (2.0 * mass1 + mass2 - mass2 * cos(2.0 * theta1 - 2.0 * theta2))
	alpha2 = (num1 * (num2 + num3 + num4)) / den
	
	# Update velocities and positions
	omega1 += alpha1 * dt
	omega2 += alpha2 * dt
	omega1 *= DAMPING
	omega2 *= DAMPING
	theta1 += omega1 * dt
	theta2 += omega2 * dt
	
	# Calculate positions
	var x1 = length1 * sin(theta1)
	var y1 = -length1 * cos(theta1)
	var x2 = x1 + length2 * sin(theta2)
	var y2 = y1 - length2 * cos(theta2)
	
	# Update first pendulum
	pendulum1.position = Vector3(0, 0, 0)  # Keep at origin
	pendulum1.rotation.z = theta1
	
	# Update second pendulum
	rigid_body.position = Vector3(0, -length1, 0)  # Position at end of first rod
	rigid_body.rotation.z = theta2 - theta1
