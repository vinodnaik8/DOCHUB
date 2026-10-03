// ==========================
// DOCHUB V2 Dashboard
// ==========================

const menuBtn = document.getElementById("menuBtn");
const closeMenu = document.getElementById("closeMenu");
const sidebar = document.getElementById("sidebar");
const overlay = document.getElementById("overlay");

// Open Sidebar
menuBtn.addEventListener("click", () => {

    sidebar.classList.add("active");

    overlay.style.display = "block";

});

// Close Sidebar
closeMenu.addEventListener("click", () => {

    sidebar.classList.remove("active");

    overlay.style.display = "none";

});

// Click Outside
overlay.addEventListener("click", () => {

    sidebar.classList.remove("active");

    overlay.style.display = "none";

});

// ESC Key
document.addEventListener("keydown", function(e){

    if(e.key==="Escape"){

        sidebar.classList.remove("active");

        overlay.style.display="none";

    }

});

// ==========================
// Search Animation
// ==========================

const search=document.querySelector(".searchBox input");

search.addEventListener("focus",()=>{

    document.querySelector(".searchBox").style.boxShadow=
    "0 0 0 4px rgba(37,99,235,.15)";

});

search.addEventListener("blur",()=>{

    document.querySelector(".searchBox").style.boxShadow=
    "0 5px 15px rgba(0,0,0,.08)";

});

// ==========================
// Upload Button
// ==========================

document.querySelector(".uploadBtn").addEventListener("click",()=>{

    window.location="upload.jsp";

});

// ==========================
// Card Hover Animation
// ==========================

const cards=document.querySelectorAll(".statCard,.actionCard,.docCard");

cards.forEach(card=>{

    card.addEventListener("mouseenter",()=>{

        card.style.transition=".25s";

    });

});

// ==========================
// Welcome Message
// ==========================

const hour=new Date().getHours();

let greeting="Welcome";

if(hour<12){

    greeting="Good Morning ☀️";

}
else if(hour<17){

    greeting="Good Afternoon 🌤";

}
else{

    greeting="Good Evening 🌙";

}

const hero=document.querySelector(".hero h1");

if(hero){

    hero.innerHTML=greeting+"<br>"+hero.innerHTML;

}

// ==========================
// Counter Animation
// ==========================

const counters=document.querySelectorAll(".statCard h2");

counters.forEach(counter=>{

    const target=parseInt(counter.innerText)||0;

    let current=0;

    const speed=25;

    const update=()=>{

        if(current<target){

            current++;

            counter.innerText=current;

            setTimeout(update,speed);

        }

    };

    if(target>0){

        counter.innerText="0";

        update();

    }

});