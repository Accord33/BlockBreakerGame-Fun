class Collision {
    float x, y, z, _width, _height, _depth, a, b, c, d, x2, y2, z2, x3, y3, z3;
    Collision(float x, float y, float z, float _width, float _height, float _depth) {
        this.x = x;
        this.y = y;
        this.z = z;
        this._width = _width;
        this._height = _height;
        this._depth = _depth;

        this.x2 = x + _width;
        this.y2 = y - _height;
        this.z2 = z + _depth;

        this.x3 = x;
        this.y3 = y - _height;
        this.z3 = z + _depth;

        // [x-x2, y-y2, z-z2]
        // [x-x3, y-y3, z-z3]
        // [y-y2*z-z3 - z-z2*y-y3]
        // [x-x2*z-z3 - x-x3*z-z3]
        // [x-x2*y-y3 - x-x3*y-y2]

        // this.a = (y-y2)*(z-z3) - (z-z2)*(y-y3);
        // this.b = (x-x2)*(z-z3) - (x-x3)*(z-z3);
        // this.c = (x-x2)*(z-z3) - (x-x3)*(z-z3);
        // this.d = -(a*x+b*y+c*z); 
        this.a = (y2-y)*(z3-z) - (y3-y)*(z2-z);
        this.b = (z2-z)*(x3-x) - (z3-z)*(x2-x);
        this.c = (x2-x)*(y3-y) - (x3-x)*(y2-y);
        this.d = -(x*a + y*b + z*c);

        // this.a = 0;
        // this.b = 30450000;
        // this.c = 0;
        // this.d = -12180000000;
        println(x, y, z);
        println(x2, y2, z2);
        println(x3, y3, z3);
        println(a, b, c, d);
        println("");
    }
    
    void update() {
        stroke(0, 255, 255);
        // noFill();
        fill(0, 255, 255);
        pushMatrix();
        translate(this.x+_width/2, this.y-_height/2, this.z+_depth/2);
        box(this._width, this._height, this._depth);
        popMatrix();
    }

    float bounce(float tx, float ty, float tz, float tv, int num) {
        if (this.x <= tx && tx <= this.x+_width) {
            if (this.z <= tz && tz <= this.z+_depth) {
                print(tx);
                print(" ");
                print(ty);
                print(" ");
                println(tz);
                float child = abs(this.a*(tx-_width) + this.b*(ty+_height) + this.c*(tz-_depth) + this.d);
                // float child = abs(this.a*tx + this.b*ty + this.c*tz + this.d);
                float mothor = sqrt(this.a*this.a + this.b*this.b + this.c*this.c);
                float ans = child/mothor;
                print("p ");
                println(this.y);
                println(ans);
                if (0 <= ans && ans < 50){
                    if (this._height == 0) {
                        return this.y;
                    }
                    else {
                        return (this.z-tz)*this._height/this.z+this.y;
                    }
                }
                // return ty;
            }
        }
        return 0;
    }
}