document.addEventListener('DOMContentLoaded', function() {
    const addButton = document.getElementById('addButton');
   
    const studentForm = document.getElementById('studentForm');

    addButton.addEventListener('click', function(event) {
        event.preventDefault();

        // Get the count of current input fields
        const inputCount = document.querySelectorAll('.dynamic-input').length;

        // Create a new div for the new input field
        const newField = document.createElement('div');
        newField.className = 'field-form';

        // Create a new input element
        const newInput = document.createElement('input');
        newInput.type = 'text';
        newInput.name = `Name ${inputCount + 1}`;
        newInput.placeholder = `Enter data ${inputCount + 1}`;
        newInput.className = 'dynamic-input';
        newInput.required = true; // Ensure the input is required
        

        // Append the new input to the new div
        newField.appendChild(newInput);

        // Append the new div to the form
        studentForm.appendChild(newField);

        // Add an event listener to update the placeholder with the input value
        newInput.addEventListener('input', function() {
            newInput.placeholder = newInput.value;
        });
    });



    // Apply the same event listener to existing dynamic inputs
    document.querySelectorAll('.dynamic-input').forEach(input => {
        input.addEventListener('input', function() {
            input.placeholder = input.value;
        });
    });
});


