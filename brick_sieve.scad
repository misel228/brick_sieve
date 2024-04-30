
// size of the holes in the sieve
sieve_size=8;

// outer diameter of everything
diameter = 200;

// height of the top outer ring
height=30;

// height of the bottom sieve ring
sieve_height=5;

// wall thickness
wall_strength=2;

in_lay=5;

// the outside of lower ring should be a little smaller than
// the inside of the upper ring so that there's a little wiggle 
// room
overhang=.1;


// width of the bars in the grid
grid_strength = 2;

// width of the lip around the grid
lip_size = 5;

// number of faces used for the cylinders
$fn=100;

/* main walls*/
// /*
difference() {
    
    cylinder(h=height, r = (diameter/2));

    cylinder(h=height, r = ((diameter - wall_strength)/2));
}

// */

/* connection between */

inner_diameter = diameter - wall_strength;

// /*
difference() {
    
    cylinder(
        h=wall_strength, 
        r = (diameter/2)
    );

    cylinder(
        h=wall_strength, 
        r = ((inner_diameter - wall_strength - overhang)/2)
    );
}

// */

/* inner walls */

// /*
translate([0,0,-1 * (sieve_height)]) 
    difference() {
        
        cylinder(
            h=sieve_height, 
            r = ((inner_diameter  - overhang) /2)
        );

        cylinder(
            h=sieve_height, 
            r = ((inner_diameter - overhang - wall_strength)/2)
        );
    }

// */
    
/* bottom */

union() {
    

/* lip */

// /*
    translate([0,0,-1 * (sieve_height)]) 
        difference() {
            
            cylinder(
                h=wall_strength, 
                r = ((inner_diameter  - overhang) /2)
            );

            cylinder(
                h= wall_strength, 
                r = ((inner_diameter - overhang - wall_strength - lip_size)/2)
            );
        }


    /* grid */
    
    difference() {
        translate([0,0,-1 * (sieve_height)])
            cylinder(
                h=wall_strength,
                r = ((inner_diameter  - overhang) /2)
            );

        translate([-(diameter/2),-(diameter/2),-1 * (sieve_height)])
        //the sieve is just a plate with regular holes
            for(y=[0:(sieve_size+grid_strength):diameter]) {
                for(x=[0:(sieve_size+grid_strength):diameter]) {
                    translate([x,y,-1]) {
                        //the holes - height doesn't actually matter, just need to be large enough
                        cube ([sieve_size,sieve_size,8]);
                    }
                }
            }
    }

// */
}