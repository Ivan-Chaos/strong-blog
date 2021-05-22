const { viewport } = require("@popperjs/core");

var extended=false;

function checkSize(){
    var pic=document.getElementById('photo');
    console.log(pic.naturalHeight);
    console.log(window.innerHeight*0.4);

    if(pic.naturalHeight<(window.innerHeight*0.4)){
        document.getElementById("opening").style.visibility="hidden";
        console.log("image small enough, allowed to keep it");
    }else{
        document.getElementById("opening").style.visibility="visible";
        console.log("Too big, make it shrinkable");
    }
}

function goBig(){
    
    if(!extended){
        console.log("Extending the pic");
        var pic=document.getElementById('photo');
        var newHeight=pic.naturalHeight*(pic.width/pic.naturalWidth)+10;
        document.getElementById('image-container').style.maxHeight=newHeight+"px";
        document.getElementById('opening').innerHTML="Collapse an image <i class='fas fa-chevron-up'></i>";
        extended=true;
    }else{
        console.log("SHRINK IT");
        document.getElementById('image-container').style.maxHeight="40vh";
        document.getElementById('opening').innerHTML="Expand an image <i class='fas fa-chevron-down'></i>";
        extended=false;
    }
}

document.addEventListener('turbolinks:load', () => {
    const pic=document.getElementById("photo");

    window.addEventListener('load', (event) => {
        console.log("chhecking for image size");
        checkSize();
    });
    
    const clickButton = document.getElementById("opening");
    clickButton.addEventListener('click', (event) => {
        goBig();
    });
});