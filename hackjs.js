let str = prompt("Nhập vào một chuỗi: ");

let a = restr(str);
console.log(a);

let b = upfisrt(str);
console.log(b);

let arr = [1, 1, 2, 2 ,3, 4, 7 , 4574, 4, 9, 0, 4, 7, 0];
let c = nosame(arr);
console.log(c);

let rra = [1, 2, 3, 4, 5, 6, 7, 8, 9,];
let n = 5;
let ans = b5(rra, n);
console.log(ans);

function restr(str){
    let temp = "";
    for(let i = str.length - 1; i >= 0; i --){
        temp += str[i];
    }
    return temp;
}

function upfisrt(str){
    let temp = "";
    temp += str[0].toUpperCase();
    for(let i = 1; i < str.length; i ++){
        if(str[i] == " "){
            temp += str[i];
            temp += str[i+1].toUpperCase();
            i = i+1;
        } else {
            temp += str[i];
        }
    }
    return temp;
}

function nosame(arr){
    let temp = {};
    let arrtemp = [];
    for(let str of arr){
        if(!temp[str]){
            arrtemp.push(str);
            temp[str] = true;
        }
    }
    return arrtemp;
}
7
function b5(arr, n){
    let numMap = {};
    for(let i = 0; i < arr.length; i++){
        let temp = n - arr[i];
        if (numMap.hasOwnProperty(temp)) {
            return [numMap[temp], i];
        }
        numMap[arr[i]] = i;
    }
    return [];
}

