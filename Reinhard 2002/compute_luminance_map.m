function luminance_map = compute_luminance_map(hdr_map)
    % Create luminance map from linear combination of the channels.
    % Source: http://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color
    %red_channel = hdr_map(:,:,1);
    %green_channel = hdr_map(:,:,2);
    %blue_channel = hdr_map(:,:,3);
    %luminance_map = 0.2126 * red_channel + 0.7152 * green_channel + 0.0722 * blue_channel;
    
    red_channel = hdr_map(:,:,1);
    green_channel = hdr_map(:,:,2);
    blue_channel = hdr_map(:,:,3);
    luminance_map = 0.2126 * red_channel + 0.7152 * green_channel + 0.0722 * blue_channel;
end