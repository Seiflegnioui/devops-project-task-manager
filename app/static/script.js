document.addEventListener('DOMContentLoaded', () => {
    const taskForm = document.getElementById('task-form');
    const taskTitleInput = document.getElementById('task-title');
    const taskList = document.getElementById('task-list');
    const taskCount = document.getElementById('task-count');
    const loadingSpinner = document.getElementById('loading');

    const API_URL = '/tasks';

    // Fetch and render tasks on load
    fetchTasks();

    // Handle form submission
    taskForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        const title = taskTitleInput.value.trim();
        if (!title) return;

        try {
            const response = await fetch(API_URL, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ title }),
            });

            if (response.ok) {
                const newTask = await response.json();
                taskTitleInput.value = '';
                fetchTasks(); // Refresh list to get all tasks
            }
        } catch (error) {
            console.error('Error adding task:', error);
            alert('Failed to add task. Please try again.');
        }
    });

    // Fetch all tasks
    async function fetchTasks() {
        showLoading(true);
        try {
            const response = await fetch(API_URL);
            if (response.ok) {
                const tasks = await response.json();
                renderTasks(tasks);
            }
        } catch (error) {
            console.error('Error fetching tasks:', error);
            taskList.innerHTML = `<div class="empty-state">Failed to load tasks.</div>`;
        } finally {
            showLoading(false);
        }
    }

    // Delete Task
    async function deleteTask(taskId) {
        try {
            const response = await fetch(`${API_URL}/${taskId}`, {
                method: 'DELETE',
            });
            if (response.ok) {
                fetchTasks();
            }
        } catch (error) {
            console.error('Error deleting task:', error);
        }
    }

    // Update Task Status
    async function updateTaskStatus(taskId, newStatus) {
        try {
            const response = await fetch(`${API_URL}/${taskId}`, {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ done: newStatus }),
            });
            if (response.ok) {
                fetchTasks();
            }
        } catch (error) {
            console.error('Error updating task:', error);
        }
    }

    // Render tasks to the DOM
    function renderTasks(tasks) {
        taskCount.textContent = tasks.length;
        taskList.innerHTML = '';

        if (tasks.length === 0) {
            taskList.innerHTML = `<div class="empty-state">No tasks yet. Add one above!</div>`;
            return;
        }

        tasks.forEach(task => {
            const li = document.createElement('li');
            li.className = `task-item ${task.done ? 'done' : ''}`;
            
            li.innerHTML = `
                <div class="task-content">
                    <label class="checkbox-container">
                        <input type="checkbox" class="task-checkbox" data-id="${task.id}" ${task.done ? 'checked' : ''}>
                        <span class="checkmark"></span>
                    </label>
                    <span class="task-title-text">${escapeHTML(task.title)}</span>
                </div>
                <div class="task-actions">
                    <button class="delete-btn" data-id="${task.id}" title="Delete Task">
                        <i class="fa-solid fa-trash-can"></i>
                    </button>
                </div>
            `;

            taskList.appendChild(li);
        });

        // Add Listeners to checkmark checkboxes
        document.querySelectorAll('.task-checkbox').forEach(checkbox => {
            checkbox.addEventListener('change', (e) => {
                const taskId = e.target.getAttribute('data-id');
                // The new status is whatever the checkbox's state currently is
                updateTaskStatus(taskId, e.target.checked);
            });
        });

        // Add Listeners to delete buttons
        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const taskId = e.currentTarget.getAttribute('data-id');
                deleteTask(taskId);
            });
        });
    }

    function showLoading(isLoading) {
        if (isLoading) {
            loadingSpinner.style.display = 'block';
            taskList.style.display = 'none';
        } else {
            loadingSpinner.style.display = 'none';
            taskList.style.display = 'flex';
        }
    }

    // Help prevent XSS
    function escapeHTML(str) {
        return str.replace(/[&<>'"]/g, 
            tag => ({
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                "'": '&#39;',
                '"': '&quot;'
            }[tag] || tag)
        );
    }
});
