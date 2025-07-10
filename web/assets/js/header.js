
function toggleUserDropdown() {
    const dropdown = document.getElementById("userDropdownMenu");
    dropdown.classList.toggle("show");
}

// Close dropdown when clicking outside
document.addEventListener('click', function (event) {
    const userContainer = document.querySelector('.user-dropdown-container');
    const dropdown = document.getElementById("userDropdownMenu");

    if (userContainer && !userContainer.contains(event.target)) {
        dropdown.classList.remove("show");
    }
});

// Mobile admin sidebar toggle (if needed)
function toggleAdminSidebar() {
    const sidebar = document.getElementById("adminSidebar");
    if (sidebar) {
        sidebar.classList.toggle("show");
    }
}

// Close mobile menu when clicking outside
document.addEventListener('click', function (event) {
    const navbarCollapse = document.getElementById('navbarNav');
    const navbarToggler = document.querySelector('.navbar-toggler');

    if (navbarCollapse && navbarToggler) {
        if (!navbarCollapse.contains(event.target) && !navbarToggler.contains(event.target)) {
            const bsCollapse = new bootstrap.Collapse(navbarCollapse, {
                toggle: false
            });
            bsCollapse.hide();
        }
    }
});