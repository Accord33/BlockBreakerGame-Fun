class Collision {
    float x, y, z, _width, _height, _depth, a, b, c, d, x2, y2, z2, x3, y3, z3;
    Collision(float x, float y, float z, float _width, float _height, float _depth) {

        // 三点の座標を取得
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

        // ベクトル化で平面の方程式を取得
        this.a = (y2-y)*(z3-z) - (y3-y)*(z2-z);
        this.b = (z2-z)*(x3-x) - (z3-z)*(x2-x);
        this.c = (x2-x)*(y3-y) - (x3-x)*(y2-y);
        this.d = -(x*a + y*b + z*c);

        // 三点の座標と方程式の要素を表示
        // println(x, y, z);
        // println(x2, y2, z2);
        // println(x3, y3, z3);
        // println(a, b, c, d);
        // println("");
    }
    
    // 当たり判定を表示
    void update() {
        // stroke(0, 255, 255);
        // noFill();
        // // fill(0, 255, 255);
        // pushMatrix();
        // translate(this.x+_width/2, this.y-_height/2, this.z+_depth/2);
        // box(this._width, this._height, this._depth);
        // popMatrix();
    }

    // 床の上を歩くための処理
    float bounce(float tx, float ty, float tz) {
        if (this.x <= tx && tx <= this.x+_width) {
            if (this.z <= tz && tz <= this.z+_depth) {
                // float child = abs(this.a*(tx-_width) + this.b*(ty+_height) + this.c*(tz-_depth) + this.d);
                float child = abs(this.a*tx + this.b*ty + this.c*tz + this.d);
                float mothor = sqrt(this.a*this.a + this.b*this.b + this.c*this.c);
                float ans = child/mothor;
                if (0 <= ans && ans < 50){
                    return -(a*tx + c*tz + d)/b;
                }
            }
        }
        return 0;
    }
}